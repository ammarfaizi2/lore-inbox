Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285246AbSACJ6g>; Thu, 3 Jan 2002 04:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285250AbSACJ6Z>; Thu, 3 Jan 2002 04:58:25 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:57351 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285246AbSACJ6N>; Thu, 3 Jan 2002 04:58:13 -0500
Date: Thu, 3 Jan 2002 09:57:42 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: "H . J . Lu" <hjl@lucon.org>, Momchil Velikov <velco@fadata.bg>,
        Oliver Xymoron <oxymoron@waste.org>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Extern variables in *.c files
Message-ID: <20020103095742.A11443@flint.arm.linux.org.uk>
In-Reply-To: <02010216180403.01928@manta> <Pine.LNX.4.43.0201021322120.30079-100000@waste.org> <3C337EF1.4C7C72AB@zip.com.au>, <3C337EF1.4C7C72AB@zip.com.au> <87ell8wgo9.fsf@fadata.bg> <3C340601.E9A3507F@zip.com.au>, <3C340601.E9A3507F@zip.com.au>; <20020102234226.A23580@lucon.org> <3C340EA9.FE084B4C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C340EA9.FE084B4C@zip.com.au>; from akpm@zip.com.au on Wed, Jan 02, 2002 at 11:56:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 11:56:25PM -0800, Andrew Morton wrote:
> Oh well.  Seems that disabling -fno-common and enabling
> --warn-common is the only way to autodetect bugs such as this.

You open another can of worms with variables in drivers that should be
static that aren't - you end up with no way to detect these without
-fno-common.

So, you have a choice:
1. Enable -fno-common
   - detect variables that should be marked static which aren't
   - don't detect size differences
2. Disable -fno-common
   - don't detect variables that should be marked static
   - detect size differences as long as the variables aren't marked extern

As soon as someone has int foo in one file, and extern char foo in another,
you've lost no matter which option you take.

The header file approach is the most reliable (and imho correct) method to
solve this problem.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

