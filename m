Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSFZBbW>; Tue, 25 Jun 2002 21:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSFZBbV>; Tue, 25 Jun 2002 21:31:21 -0400
Received: from zok.SGI.COM ([204.94.215.101]:7625 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316213AbSFZBbV>;
	Tue, 25 Jun 2002 21:31:21 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMTAB, or Is "this_object_must_be_defined_as_export_objs_in_the_Makefile" annoying to anyone? 
In-reply-to: Your message of "Tue, 25 Jun 2002 19:16:58 -0400."
             <Pine.LNX.4.33L2.0206251914230.28225-100000@rtlab.med.cornell.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Jun 2002 11:31:14 +1000
Message-ID: <12845.1025055074@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002 19:16:58 -0400 (EDT), 
"Calin A. Culianu" <calin@ajvar.org> wrote:
>I am not sure for the reasoning behind it, but it seems that newer 2.4
>kernels require the additional -DEXPORT_SYMTAB be defined for any code one
>wants to build as a module (if that module exports symbols).  Needless to
>say this breaks a lot of (non-kernel-tree) modules that would otherwise
>have been compiling without problems.
>
>What is the rationale behind this?

Any code that exports symbols must be compiled with -DEXPORT_SYMTAB.
That flag is used in module symbol version processing to generate the
versioned symbols.

It used to be that omitting -DEXPORT_SYMTAB would only cause an error
when CONFIG_MODVERSIONS=y.  Since most developers did not use
modversions, entries were being added to the kernel tree without
correct makefile definitions.  To ensure correct definitions in the
makefile for all circumstances, the code was changed to always require
-DEXPORT_SYMTAB for exporting objects, with or without
CONFIG_MODVERSIONS.

Bottom line: if you export symbols you must always define -DEXPORT_SYMTAB.

