Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVAKCSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVAKCSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVAKA6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:58:03 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:12030 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262763AbVAKAmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:42:45 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: YhLu <YhLu@tyan.com>
Subject: Re: 256 apic id for amd64
Date: Mon, 10 Jan 2005 16:42:41 -0800
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@muc.de>, "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
References: <3174569B9743D511922F00A0C94314230729139F@TYANWEB>
In-Reply-To: <3174569B9743D511922F00A0C94314230729139F@TYANWEB>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501101642.41783.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings YH,

That patch will cause phys_proc_id[] to contain incorrect information 
for IBM x366 systems.  There is a reason why phys_pkg_id() indirects 
through the subarch table -- it does so because cpuid returns stale 
data when the APIC ID registers are rewritten by the x366 BIOS.  The 
BIOS must rewrite those registers as part of system probing and 
configuration (i.e. Nocona chips can't latch all 8 bits of APIC ID at 
reset time, and we will need all 8 bits real soon).

Personally, I don't have any problem with replacing the non-power-of-2 
code with "hweight32(c->x86_num_cores - 1)", but folks at Intel have 
been very insistent that it may be needed in the future.  Maybe Suresh 
can speak up about Intel's interests here.


On Monday 10 January 2005 11:41 am, YhLu wrote:
> Please refer the patch.
>
> Regards
>
> YH

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
