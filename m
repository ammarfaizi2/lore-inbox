Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSAFWVa>; Sun, 6 Jan 2002 17:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbSAFWU0>; Sun, 6 Jan 2002 17:20:26 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:50449 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285829AbSAFWUO>;
	Sun, 6 Jan 2002 17:20:14 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system 
In-Reply-To: Your message of "Sun, 06 Jan 2002 09:55:49 BST."
             <20020106095549.A664@ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Jan 2002 09:19:59 +1100
Message-ID: <23415.1010355599@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002 09:55:49 +0100, 
Martin Mares <mj@ucw.cz> wrote:
>Is there any reason for processing all the files for each compile
>instead of merging them to a single file once at the start of the make?

The main reason is to convert absolute dependency names to $(xxx)
followed by a relative name, where xxx is one of the KBUILD_OBJTREE or
KBUILD_SRCTREE_nnn variables.  This conversion allows users to rename
their source and object trees and to compile on one machine and install
on another over NFS without being bitten by absolute dependencies.  I
really need to do that conversion using the current values of the
kbuild variables, the variables might have changed on the next make.

My new design for module symbol versions requires that the version data
be stored immediately after the compile.  That also requires processing
after each compile using the current environment.

