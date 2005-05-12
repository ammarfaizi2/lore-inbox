Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVELVJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVELVJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVELVJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:09:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:20661 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262120AbVELVJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:09:39 -0400
In-Reply-To: <E1DVoUW-0001cN-00@dorka.pomaz.szeredi.hu>
To: Miklos Szeredi <miklos@szeredi.hu>, ericvh@gmail.com, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com
MIME-Version: 1.0
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF1BD633A3.AED1499B-ON88256FFF.006E4A76-88256FFF.00742B3D@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 12 May 2005 14:08:21 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_04122005|April 12, 2005) at
 05/12/2005 17:09:22,
	Serialize complete at 05/12/2005 17:09:22
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So if a user creates a private namespace, it should have the choice of:
> 
>    1) Giving up all suid rights (i.e. all mounts are cloned and
>       propagated with nosuid)
> 
>    2) Not giving up suid for cloned and propagated mounts, but having
>       extra limitations (suid/sgid programs cannot access unprivileged
>       "synthetic" mounts)

(2) isn't realistic.  There's no such thing as a suid program.  Suid is a 
characteristic of a _file_.  There's no way to know whether a given 
executing program is running with privileges that came from a suid file 
getting exec'ed.  Bear in mind that that exec could be pretty remote -- 
done by a now-dead ancestor with three more execs in between.

Many user space programs contain hacks to try to discern this information, 
and they often cause me headaches and I have to fix them.  The usual hacks 
are euid==uid, euid==suid, and/or euid==0.  It would be an order of 
magnitude worse for the kernel to contain such a hack.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
