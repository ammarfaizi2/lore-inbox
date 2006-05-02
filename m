Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWEBIGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWEBIGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWEBIGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:06:22 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:64483 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932500AbWEBIGU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:06:20 -0400
In-Reply-To: <20060428174302.GE30532@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] s390: Hypervisor File System
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF447CA378.B752E923-ON42257162.002BBE49-42257162.002C8138@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Tue, 2 May 2006 10:06:06 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 02/05/2006 10:07:09
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joern,

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 04/28/2006 07:43:02 PM:
> On Fri, 28 April 2006 19:36:30 +0200, Michael Holzheu wrote:
> > Andrew Morton <akpm@osdl.org> wrote on 04/28/2006 11:56:21 AM:
> > > Michael Holzheu <holzheu@de.ibm.com> wrote:
> >
> > > > +static int diag224_idx2name(int index, char *name)
> > > > +{
> > > > +   memcpy(name, diag224_cpu_names + ((index + 1) * 16), 16);
> > > > +   name[16] = 0;
> > >
> > > Should this be "15"?   I guess not...
> >
> > No bug, our strings here have 16 characters and are not
> > 0 terminated.
>
> Hmm.  TMP_SIZE is defined to 64 and used for buffers allocated on the
> stack.  It is not too excessive, but in this case 17 would definitely
> be enough.  Not sure if it's worth going through.
>
> Jörn

Since I use the buffers with size TMP_SIZE also for other purposes
in the same functions, where the cpu types are accessed,
I think, it is not useful to define a second buffer with size 17.

But I think it is better to have a define for the buffer size
of cpu names. something like:

 #define LPAR_NAME_LEN 8                /* lpar name len in diag 204 data
*/
+#define CPU_NAME_LEN 16                /* type name len of a cpu in
diag224 name table */
 #define TMP_SIZE 64            /* size of temporary buffers */

 static int diag224_idx2name(int index, char *name)
 {
-       memcpy(name, diag224_cpu_names + ((index + 1) * 16), 16);
-       name[16] = 0;
+       memcpy(name, diag224_cpu_names + ((index + 1) * CPU_NAME_LEN),
+               CPU_NAME_LEN);
+       name[CPU_NAME_LEN] = 0;
        strstrip(name);
        return 0;
 }

Michael

