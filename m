Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283204AbSABO4p>; Wed, 2 Jan 2002 09:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287827AbSABO4h>; Wed, 2 Jan 2002 09:56:37 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:6861 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S283204AbSABO4b>; Wed, 2 Jan 2002 09:56:31 -0500
Date: Wed, 2 Jan 2002 14:56:03 +0000 (GMT)
From: "Joseph S. Myers" <jsm28@cam.ac.uk>
X-X-Sender: <jsm28@kern.srcf.societies.cam.ac.uk>
To: Tom Rini <trini@kernel.crashing.org>
cc: Momchil Velikov <velco@fadata.bg>, <linux-kernel@vger.kernel.org>,
        <gcc@gcc.gnu.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0201021451390.18982-100000@kern.srcf.societies.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002, Tom Rini wrote:

> 3) We could also try turning off this particular optimization
> (-fno-builtin perhaps) on this file, and not worry about it.

In particular, it would probably make sense for the kernel to use 
-ffreestanding (which implies -fno-builtin) throughout then selectively 
enable the built-in functions that are wanted with macros such as

#define strcpy(d, s) __builtin_strcpy((d), (s))

in an appropriate header, then #undef these macros in the files that
shouldn't use the built-in functions.

-- 
Joseph S. Myers
jsm28@cam.ac.uk

