Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSGON13>; Mon, 15 Jul 2002 09:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317480AbSGON12>; Mon, 15 Jul 2002 09:27:28 -0400
Received: from ping.uio.no ([129.240.78.2]:4112 "EHLO ping.uio.no")
	by vger.kernel.org with ESMTP id <S317468AbSGON11>;
	Mon, 15 Jul 2002 09:27:27 -0400
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Killing/removing defunct processes?
References: <200207151442.57464.roy@karlsbakk.net>
From: ilmari@ping.uio.no (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Date: 15 Jul 2002 15:30:19 +0200
In-Reply-To: <200207151442.57464.roy@karlsbakk.net>
Message-ID: <d8jadotqftg.fsf@wirth.ping.uio.no>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk <roy@karlsbakk.net> writes:

> hi all
Hi Roy,
 
> How can I kill/remove a defunct process (trying to read on from a
> chrashed NFS server) without rebooting? It really should be some
> sort of hack (extra kill argument?) to do this.

>From nfs(5), mount options:

   hard    If an NFS file operation has a major timeout then report
           "server not responding" on the console and continue
           retrying indefinitely.  This is the default.

   intr    If an NFS file operation has a major timeout and it is hard
           mounted, then allow signals to interupt the file operation
           and cause it to return EINTR to the calling program.  The
           default is to not allow file operations to be interrupted.

You want both these options when mounting. It might be possible to do a
"mount -o remount,intr /hung/nfs/mount" and then kill, but I'm not sure.

-- 
ilmari
