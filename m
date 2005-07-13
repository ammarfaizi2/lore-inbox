Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVGMXLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVGMXLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVGMXKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:10:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56314 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262270AbVGMXJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:09:34 -0400
Message-ID: <42D59EB5.6040200@mvista.com>
Date: Wed, 13 Jul 2005 16:07:33 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz>	 <42D540C2.9060201@tmr.com>	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>	 <20050713184227.GB2072@ucw.cz>	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>	 <1121282025.4435.70.camel@mindpipe>	 <d120d50005071312322b5d4bff@mail.gmail.com>	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>	 <20050713211650.GA12127@taniwha.stupidest.org> <1121289881.4435.102.camel@mindpipe>
In-Reply-To: <1121289881.4435.102.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2005-07-13 at 14:16 -0700, Chris Wedgwood wrote:
> 
>>Both can be detected from you .config and we could see HZ as needed
>>there and everyone else could avoid this surely?

> 
> Does anyone object to setting HZ at boot?  I suspect nothing else will
> make everyone happy.
> 
This will really mess up the jiffie_to_* and *_to_jiffie conversions.  They rely 
in a rather large way on the complier doing all the heavy lifting.  If HZ is a 
variable we introduce a LOT of runtime overhead here.  (Try make kernel/itimer.i 
and look for jiffies_to_t* and friends.)


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
