Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbTLKTzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbTLKTzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:55:23 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:58010 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S265231AbTLKTzR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:55:17 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "=?utf-8?Q?'J=E9=B0=8En_Engel'?=" <joern@wohnheim.fh-wedel.de>
Cc: "'Andy Isaacson'" <adi@hexapodia.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Is there a "make hole" (truncate in middle) syscall?
Date: Thu, 11 Dec 2003 11:55:13 -0800
Organization: Cisco Systems
Message-ID: <018201c3c020$b0bf7650$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20031211194815.GA10029@wohnheim.fh-wedel.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Understood. Two filesystems we are using: tmpfs and ext3. For the
> > former, fragmentation doesn't matter.
> > 
> > Hey, I think when I get some cycles I can try to implement this for
> > tmpfs (since it's simpler) myself, and post a patch. :-) But before
> > that, I want to make sure it's doable.
> 
> If you really do it, please don't add a syscall for it.  Simply check
> each written page if it is completely filled with zero.  (This will be
> a very quick check for most pages, as they will contain something
> nonzero in the first couple of words)

You mean automatically punch it?

I don't think this is desirable. As someone else pointed out, "punch" might be an expensive operation and cause fragmentation (since you return the block in the middle to the fs).

I think this operation should be performed only when the application requires it.
 
> Jörn

