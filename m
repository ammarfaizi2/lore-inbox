Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVHIRZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVHIRZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVHIRZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:25:27 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:37307 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932470AbVHIRZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:25:26 -0400
Message-ID: <0D2F5426C26FD511A1C400B0D0D0596801569238@deliverance.tycho.ncsc.mil>
From: "DuBuisson, Thomas" <tmdubui@tycho.ncsc.mil>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [BUG] pfkey implementation vs. RFC
Date: Tue, 9 Aug 2005 13:22:15 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted this to linux-net and netdev but have had no response.  If there
is any confusion about what the bug is then just e-mail me for
clarification.  If this is an intentional omission then could someone let me
know why.

Section 3.1.6 of RFC 2367 clearly indicates there are two 
cases in which user space programs can send the kernel pfkey 
'acquire' messages.  The first case is just the 'struct sadb_msg' 
header that should specify an error relating to a previous 
acquire message.  The second case is intended for use by routing
daemons and the like.  This case is not implemented in the Linux 
kernel - I have reprinted the relevant portion of the RFC below:
 
------------------
   The third is where an application-layer consumer of security
   associations (e.g.  an OSPFv2 or RIPv2 daemon) needs a security
   association.

        Send an SADB_ACQUIRE message from a user process to the kernel.

        <base, address(SD), (address(P),) (identity(SD),) (sensitivity,)
proposal>

        The kernel returns an SADB_ACQUIRE message to registered sockets.
 
        <base, address(SD), (address(P),) (identity(SD),) (sensitivity,)
proposal>

        The user-level consumer waits for an SADB_UPDATE or SADB_ADD
        message for its particular type, and then can use that
        association by using SADB_GET messages.
----------

As one can see in net/key/af_key.c:pfkey_acquire() the only acquire messages
accepted are of format <base> and with errno != 0.

Now for the barrage of questions:
Was this omitted for a reason?
Are we aware this was omitted?
Does someone already have a patch?
Would a patch be accepted for 2.6.13 if it is sent in time?  
This is a bug after all.
 
Cheers,
Thomas

