Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263931AbTCWVmM>; Sun, 23 Mar 2003 16:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263933AbTCWVmL>; Sun, 23 Mar 2003 16:42:11 -0500
Received: from h-64-105-35-106.SNVACAID.covad.net ([64.105.35.106]:56984 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263931AbTCWVly>; Sun, 23 Mar 2003 16:41:54 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 23 Mar 2003 13:52:43 -0800
Message-Id: <200303232152.NAA01475@adam.yggdrasil.com>
To: hch@infraded.org, linux-kernel@vger.kernel.org
Subject: Re: i2c-via686a driver
Cc: dominik@kubla.de, j.dittmer@portrix.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-03-23, Christoph Hellwig wrote:
>Because there's a strong preference for traditional C style in the kernel.
>typedefs are also a valid C feature and we try to avoid them.

	It's not so simple.  I think trade-offs of maintainability
versus other benefits determine these preferences on a
feature-by-feature basis.

	GNU features, such as inline routines, asm, __section__, and
variable sized arrays on the stack are used because the performance
benefits or other capabilities that they enable are generally
perceived to outweigh the loss in portability (although I think
__section__ is only used in macros).

	Function prototypes are used consistently throughout the
kernel and are a newer feature than typedefs, presumably because the
benefits of the type checking are greater than the benefits of
compatability with old K&R compilers.  Indeed, the benefits of such
compatability are apparently perceived as small enough, that they're
not even worth the readability costs of using macros to support
compilers with and without function prototypes.

	The kernel frequently uses typedefs for sizing integer fields,
presumably because the benefits of easing cross-platform portability
and occasional changes to these fields' sizes are perceived to
outweigh the fact you have to look up or remember the definitions
types if you want to know their exact values from the source code.

	On the other hand, it is true that typedefs seem to be avoided
in certain cases.  The kernel usually does not use typedefs for
structs and enums.  Those features provide their own name spaces, and
the readability benefits of seeing "struct" or "enum" in front of the
relevant type names is believed to outweigh the readability benefits
of having one less word to look at (but not immediately knowing if you
are looking at a struct, enum or other type).

	There is also some interest in trying to be relatively
standard when the costs of doing so are small enough.  For example,
most of the named initializers for struct fields have now been
converted from GNU style to C99 style.

	In the case of the traditional C versus C++ style comments,
using one comment type throughout the kernel may have some slight
readability benefits.  Also, partly because we have inline routines
that usually eliminate the performance cost of breaking up routines
into smaller carefully named routines for documentation purposes,
"chapter 5" of Documentation/CodingStyle says, "try to avoid putting
comments in a function body", a style for which the more
block-oriented "/*...*/" syntax is perhaps better suited.

	On the other hand '//' appears in 1805 .c and .h files in
linux-2.5.65-bk4, so, while I would prefer sticking with C style
comments, it does not appear to be a requirement for integration into
the stock kernel.  Given that your use of this feature seems to be for
a comment block, I would still encourage you to use traditional C
style comments, although it's certainly not my call.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
