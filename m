Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVAJUb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVAJUb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVAJU2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:28:42 -0500
Received: from mail.tyan.com ([66.122.195.4]:28685 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262469AbVAJUZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:25:56 -0500
Message-ID: <3174569B9743D511922F00A0C9431423072913A6@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Mon, 10 Jan 2005 12:37:29 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are right, it should be separate that to init_amd and init_intel.

I guess for intel dual core initial apic id different to AMD.
It could be 0,7 for node0. 1, 6 for node1......

Amd would be (0, 1) for node 0, (2,3) for node1 ....

YH

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Monday, January 10, 2005 12:19 PM
To: YhLu
Cc: 'Mikael Pettersson'; jamesclv@us.ibm.com; Matt_Domsch@dell.com;
discuss@x86-64.org; linux-kernel@vger.kernel.org; suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

On Mon, Jan 10, 2005 at 12:09:48PM -0800, YhLu wrote:
> Try this one.

I don't think it will work at all on Intel HT systems, since
nobody initializes c->x86_num_cores there. phys_proc_id[] 
is supposed to be the same on two HT siblings.

You'll either need to initialize c->x86_num_cores on Intel too.
But since Intel seems to have dual cores upcomming and you'll
want HyperThreading support too it would need to be a new field.

Alternatively you can split the function for AMD and Intel and
use the new algorithm on AMD only.  Perhaps that's better.
In the later case I would only use it when CMP_LEGACY is set.  

-Andi
