Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932355AbWFEBEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWFEBEv (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWFEBEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:04:51 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:993 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932355AbWFEBEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:04:50 -0400
Message-ID: <349469486.25534@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 5 Jun 2006 09:05:01 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Peschke <mp3@de.ibm.com>
Subject: statistics infrastructure
Message-ID: <20060605010501.GA4931@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <fengguang.wu@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Martin Peschke <mp3@de.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> statistics-infrastructure.patch
 
>  Another tough one.  It offers generic intrastructure for non-task-related
>  instrumentation and it would really be good if someone who has an interest
>  in this for something other than the zfcp driver could stand up and say
>  "this works for us".

I'm having a try of it. Looks good for my case, except some fixable
issues/bugs. Here is a sample session for querying the readahead statistics:

root ~# echo state=on > /debug/statistics/readahead/definition
root ~# cat /debug/statistics/readahead/definition
name=io_block state=on units=/ type=counter_inc data=[  108.272356] started=[  218.797000] stopped=[  201.533118]
name=read_random state=on units=pages/requests type=utilisation data=[  108.272459] started=[  218.797004] stopped=[  201.533146]
name=readahead-fadvise state=on units=pages/requests type=utilisation data=[  108.272472] started=[  218.797005] stopped=[  201.533149]
name=readahead-stock state=on units=pages/requests type=utilisation data=[  108.272476] started=[  218.797005] stopped=[  201.533152]
name=readaround-mmap state=on units=pages/requests type=utilisation data=[  108.272479] started=[  218.797006] stopped=[  201.533155]
name=readahead-mmap state=on units=pages/requests type=utilisation data=[  108.272482] started=[  218.797006] stopped=[  201.533158]
name=readahead-initial state=on units=pages/requests type=utilisation data=[  108.272485] started=[  218.797007] stopped=[  201.533161]
name=readahead-state state=on units=pages/requests type=utilisation data=[  108.272488] started=[  218.797007] stopped=[  201.533164]
name=readahead-context state=on units=pages/requests type=utilisation data=[  108.272491] started=[  218.797008] stopped=[  201.533166]
name=readahead-contexta state=on units=pages/requests type=utilisation data=[  108.272494] started=[  218.797008] stopped=[  201.533169]
name=readahead-backward state=on units=pages/requests type=utilisation data=[  108.272497] started=[  218.797009] stopped=[  201.533172]
name=readahead-onthrash state=on units=pages/requests type=utilisation data=[  108.272500] started=[  218.797009] stopped=[  201.533175]
name=readahead-onseek state=on units=pages/requests type=utilisation data=[  108.272503] started=[  218.797010] stopped=[  201.533178]
name=rescue state=on units=pages/chunks type=utilisation data=[  108.272506] started=[  218.797011] stopped=[  201.533181]
name=size_drop state=on units=from-pages/delta-pages type=counter_inc data=[  108.272509] started=[  218.797011] stopped=[  201.533184]
root ~# cat /debug/statistics/readahead/data
io_block 40
read_random 0 0 0.000 0
readahead-fadvise 0 0 0.000 0
readahead-stock 0 0 0.000 0
readaround-mmap 7 1 28.286 88
readahead-mmap 0 0 0.000 0
readahead-initial 2 5 5.000 5
readahead-state 1331 256 256.010 269
readahead-context 0 0 0.000 0
readahead-contexta 0 0 0.000 0
readahead-backward 0 0 0.000 0
readahead-onthrash 0 0 0.000 0
readahead-onseek 0 0 0.000 0
rescue 0 0 0.000 0
size_drop 13
root ~#
root ~# echo  name=readahead-initial type=histogram_lin entries=32 range_min=8 base_interval=8 > /debug/statistics/readahead/definition
root ~# cat /debug/statistics/readahead/data
io_block 53
read_random 0 0 0.000 0
readahead-fadvise 0 0 0.000 0
readahead-stock 0 0 0.000 0
readaround-mmap 7 1 28.286 88
readahead-mmap 0 0 0.000 0
readahead-initial <=8 0
readahead-initial <=16 0
readahead-initial <=24 0
readahead-initial <=32 0
readahead-initial <=40 0
readahead-initial <=48 0
readahead-initial <=56 0
readahead-initial <=64 0
readahead-initial <=72 0
readahead-initial <=80 0
readahead-initial <=88 0
readahead-initial <=96 0
readahead-initial <=104 0
readahead-initial <=112 0
readahead-initial <=120 0
readahead-initial <=128 0
readahead-initial <=136 0
readahead-initial <=144 0
readahead-initial <=152 0
readahead-initial <=160 0
readahead-initial <=168 0
readahead-initial <=176 0
readahead-initial <=184 0
readahead-initial <=192 0
readahead-initial <=200 0
readahead-initial <=208 0
readahead-initial <=216 0
readahead-initial <=224 0
readahead-initial <=232 0
readahead-initial <=240 0
readahead-initial <=248 0
readahead-initial >248 0
readahead-state 1331 256 256.010 269
readahead-context 0 0 0.000 0
readahead-contexta 0 0 0.000 0
readahead-backward 0 0 0.000 0
readahead-onthrash 0 0 0.000 0
readahead-onseek 0 0 0.000 0
rescue 0 0 0.000 0
size_drop 13
