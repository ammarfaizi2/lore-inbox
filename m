Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUGFXHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUGFXHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUGFXHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:07:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50444 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264686AbUGFXHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:07:44 -0400
Date: Wed, 7 Jul 2004 00:07:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-ID: <20040707000738.E28227@flint.arm.linux.org.uk>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <20040706153417.237e454e.akpm@osdl.org> <20040706154555.79673f14.davem@redhat.com> <20040706225255.GU21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040706225255.GU21066@holomorphy.com>; from wli@holomorphy.com on Tue, Jul 06, 2004 at 03:52:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 03:52:55PM -0700, William Lee Irwin III wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >>> Third, some naive check for undefined symbols failed to understand the
> >>> relocation types indicating that a given operand refers to some hard
> >>> register, which manifest as undefined symbols in ELF executables. A
> >>> patch to refine its criteria, which I used to build with, follows. rmk
> >>> and hpa have some other ideas on this undefined symbol issue I've not
> >>> quite had the opportunity to get a clear statement of yet.
> 
> On Tue, 6 Jul 2004 15:34:17 -0700 Andrew Morton <akpm@osdl.org> wrote:
> > > I converted that to a non-fatal warning due to the same problem on sparc64.
> 
> On Tue, Jul 06, 2004 at 03:45:55PM -0700, David S. Miller wrote:
> > Andrew, Russell posted to us in private email an objdump based
> > check that didn't trigger for the register declaration case.
> 
> He seems not to have cc:'d me. Apparently *UND* isn't always the fourth
> field so he did objdump --syms vmlinux | grep '^[^R][^E][^G].*\*UND\*'
> instead of the awk expression I brewed up.

Well, it seems it doesn't work for the .tmp_vmlinux1 object:

$ arm-linux-objdump --syms .tmp_vmlinux1 | egrep '^([^R]|R[^E]|RE[^G]).*\*UND\*'
00000000  w      *UND*  00000000 kallsyms_addresses
00000000  w      *UND*  00000000 kallsyms_num_syms
00000000  w      *UND*  00000000 kallsyms_names
$ arm-linux-nm .tmp_vmlinux1 | grep kallsyms_names
         w kallsyms_names

Seems we can't win either way. ;(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
