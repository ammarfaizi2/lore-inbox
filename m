Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbWECMvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWECMvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWECMvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:51:47 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:61172 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965056AbWECMvq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:51:46 -0400
In-Reply-To: <20060503123339.GB19537@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] s390: Hypervisor File System
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com, Pekka J Enberg <penberg@cs.Helsinki.FI>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF4A608E41.FE0C2D7F-ON42257163.00461225-42257163.0046AB62@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 3 May 2006 14:51:53 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 14:52:55
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn,

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 05/03/2006 02:33:39 PM:
> On Wed, 3 May 2006 14:11:36 +0200, Michael Holzheu wrote:
> >
> > Maybe we need that, too. But I think the advantage of the
> > one file solution moves the complexity from the kernel
> > to userspace.
>
> Now might be a time to come back to Martin's prediction. ;)
>
> Having a weird format in some file does _not_ move complexity from the
> kernel.  It may make the userspace more complex, granted.  But once
> you try to change something, you need to keep the ABI stable.  And
> part of the ABI is you file format.

This is also true, if you use a filesystem tree. The tree structure and
the content of the files are part of your ABI. There is no difference
between a standard tag based file (all kernel files should use the
same format of course!) and a filesystem tree.

> Applications will depend on some arcane detail of your format.  They
> will depend on exactly five spaces in "foo     bar".  It does not even
> matter if you documented "any amount of whitespace".  The application
> knows that it was five spaces and doesn't care.  And once you change
> it, the blame will be on you, because you broke existing userspace.

Again, logically there is no difference between the two solutions. It does
not matter, if you have one file with:

<cpu>
    <0>
       <onlinetime = 4711>
    <\0>
<\cpu>

... or whatever the standard kernel format will be
... and a filesystem tree with:

+cpu
   + 0
      + onlinetime


If you implement a standard userspace parser, you can access the
attributes in one file as easyly as the attributes in a filesystem tree.

Michael

