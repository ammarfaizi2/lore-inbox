Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288660AbSATOrB>; Sun, 20 Jan 2002 09:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288661AbSATOqw>; Sun, 20 Jan 2002 09:46:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57106 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288660AbSATOqn>;
	Sun, 20 Jan 2002 09:46:43 -0500
Message-ID: <3C4AD851.BF710747@mandrakesoft.com>
Date: Sun, 20 Jan 2002 09:46:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: zippel@linux-m68k.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: AFFS oops.
In-Reply-To: <20020120142811.A22052@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> >>EIP; c01de496 <affs_commit_write_ofs+72/698>   <=====
> Trace; c01ded06 <affs_truncate+206/384>
> Trace; c0126480 <do_swap_page+84/ec>
> Trace; c01264e0 <do_swap_page+e4/ec>

This oops is pretty obvious:

      res = mapping->a_ops->prepare_write(NULL, page, size, size);
      if (!res)
              res = mapping->a_ops->commit_write(NULL, page, size,
size);

...and then affs_commit_write_ofs de-references arg1 first thing.

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
