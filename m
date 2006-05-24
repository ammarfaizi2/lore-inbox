Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWEXRiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWEXRiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWEXRiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:38:25 -0400
Received: from nevyn.them.org ([66.93.172.17]:25258 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932309AbWEXRiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:38:25 -0400
Date: Wed, 24 May 2006 13:38:22 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Program to convert core file to executable.
Message-ID: <20060524173821.GA1292@nevyn.them.org>
Mail-Followup-To: vamsi krishna <vamsi.krishnak@gmail.com>,
	linux-kernel@vger.kernel.org
References: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 10:48:31PM +0530, vamsi krishna wrote:
> Hello All,
> 
> o I have written the following program to convert a core file to a
> executable, and tried to execute the converted executable but my
> system __HANGED__, The kernel did'nt give any messages the complete
> system was stuck.
> 
> o Theoretically , the OS loader should jump into the virtual address
> specified at 'ELF_HDR.e_entry and start executing instructions from
> that point if the ELF_TYPE is ET_EXEC.
> 
> o So I wrote a program which
> changes ELF_TYPE form ET_CORE to ET_EXEC and modifies e_entry to
> virtual address of the 'main' symbol, since the core file has valid offset
> to access the PHDRS, and for ET_EXEC the elf loader just need to map
> the PHDRS at the vaddr specified and start jump to e_entry.

Look at the program headers.  Many of them probably have a file size of
zero.  The code segments from the executable and shared libraries
aren't present in the core file.

Of course, the kernel shouldn't crash!  It sounds like a bug.

-- 
Daniel Jacobowitz
CodeSourcery
