Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262619AbTCZXLb>; Wed, 26 Mar 2003 18:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbTCZXLb>; Wed, 26 Mar 2003 18:11:31 -0500
Received: from sj-core-1.cisco.com ([171.71.177.237]:61611 "EHLO
	sj-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S262619AbTCZXLa>; Wed, 26 Mar 2003 18:11:30 -0500
Message-Id: <5.1.0.14.2.20030327101650.03161e00@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 27 Mar 2003 10:21:11 +1100
To: Lars Marowsky-Bree <lmb@suse.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] ENBD for 2.5.64
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
       ptb@it.uc3m.es, Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030326225617.GB13344@marowsky-bree.de>
References: <5.1.0.14.2.20030327091616.03a2ce60@mira-sjcm-3.cisco.com>
 <5.1.0.14.2.20030327091616.03a2ce60@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

At 11:56 PM 26/03/2003 +0100, Lars Marowsky-Bree wrote:
[..]
>We do parse device specific information in order to auto-configure the md
>multipath at setup time. After that, magic is on disk...
>
> > does one now need to add logic into the kernel to provide some multipathing
> > for HDS disks?
>
>Topology discovery is user-space! It does not need to live in the kernel.

i think we're agreeing on the same thing here!

yes, i believe topology discovery should only belong in userspace.
i believe it should be in userspace for both (a) setup and (b) at 
kernel-boot-time

likewise, i believe policy of deciding what mix of i/o's to put down 
different paths also belongs in userspace.
this could take the form of a daemon that frequently looks up statistics 
from the kernel (e.g. average latency per target), and uses that 
information in conjunction with some 'policy' to tweak what paths are used.
but i definitely don't think that the kernel should make any wide-ranging 
decisions about multiple paths, except beyond something like "deviceA has 
disappeared.  i know that deviceB is an alternate path, so will swing all 
outstanding i/o plugged into A to B".


cheers,

lincoln.

