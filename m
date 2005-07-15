Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVGOAF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVGOAF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVGOAF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:05:27 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:52894 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262872AbVGOAEu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:04:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r8sa/klHxcyiqS2BBRGO20fS0Uzk7QBy+CkZXFttYQr3LRnK0nRFgXplzfOinLG9uB5p4rn0HORMtqbo7lJeYQN0gVQ3oldXp8Fnp0sxgB769v5SGIPUF5vKZoJmmbUXk/DgZkpIDmTJZxGf+QB5veNvE0VRCjSNEf7Wcwvc3y8=
Message-ID: <9a874849050714170465c979c3@mail.gmail.com>
Date: Fri, 15 Jul 2005 02:04:50 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <20050713211650.GA12127@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42D3E852.5060704@mvista.com> <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe>
	 <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/05, Chris Wedgwood <cw@f00f.org> wrote:
> On Wed, Jul 13, 2005 at 01:48:57PM -0700, Andrew Morton wrote:
> 
> > Len Brown, a year ago: "The bottom line number to laptop users is
> > battery lifetime.  Just today somebody complained to me that Windows
> > gets twice the battery life that Linux does."
> 
> It seems the motivation for lower HZ is really:
> 
>    (1) ACPI/SMM suckage in laptops
> 
>    (2) NUMA systems with *horrible* remote memory latencies
> 
> Both can be detected from you .config and we could see HZ as needed
> there and everyone else could avoid this surely?
> 

While reading this thread it occoured to me that perhaps what we
really want (besides sub HZ timers) might be for the kernel to
auto-tune HZ?

Would it make sense to introduce a new config option (say
CONFIG_HZ_AUTO) that when selected does something like this at boot:

if (running_on_a_laptop()) {
    set_HZ_to(250);
} else if (running_on_large_NUMA_box()) {
    set_HZ_to_100();
} else if (running_on_multimedia_box() {
    set_HZ_to_1000();
} else {
    set_HZ_to_some_other_sane_default();
}

and if user wants to not use the auto detection they can select a
certain HZ in their .config instead of CONFIG_HZ_AUTO.


Just wanted to throw the idea up in the air in case it made sense.
Feel free to pick it apart or simply ignore it. :-)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
