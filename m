Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270613AbTGNPds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270638AbTGNPds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:33:48 -0400
Received: from palrel13.hp.com ([156.153.255.238]:39312 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S270613AbTGNPdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:33:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16146.53424.388683.213654@napali.hpl.hp.com>
Date: Mon, 14 Jul 2003 08:48:00 -0700
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof (siginfo_t) problem
In-Reply-To: <20030714084000.J15481@devserv.devel.redhat.com>
References: <20030714084000.J15481@devserv.devel.redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 14 Jul 2003 08:40:00 -0400, Jakub Jelinek <jakub@redhat.com> said:

  Jakub> # if __WORDSIZE == 64
  Jakub> #  define __SI_PAD_SIZE     ((__SI_MAX_SIZE / sizeof (int)) - 4)
  Jakub> # else
  Jakub> #  define __SI_PAD_SIZE     ((__SI_MAX_SIZE / sizeof (int)) - 3)
  Jakub> # endif

  Jakub> typedef struct siginfo
  Jakub> {
  Jakub> int si_signo;               /* Signal number.  */
  Jakub> int si_errno;               /* If non-zero, an errno value associated with
  Jakub> this signal, as defined in <errno.h>.  */
  Jakub> int si_code;                /* Signal code.  */

  Jakub> union
  Jakub> {
  Jakub> int _pad[__SI_PAD_SIZE];
  Jakub> ...
  Jakub> struct
  Jakub> {
  Jakub> void *si_addr;      /* Faulting insn/memory ref.  */
  Jakub> } _sigfault;
  Jakub> ...
  Jakub> } _sifields;
  Jakub> } siginfo_t;

  Jakub> The kernel unfortunately does this right on sparc64 and alpha
  Jakub> from 64-bit arches only; ia64, s390x, ppc64 etc. got it
  Jakub> wrong.

The ia64 kernel defines in asm-ia64/siginfo.h:

#define SI_PAD_SIZE	((SI_MAX_SIZE/sizeof(int)) - 4)

typedef struct siginfo {
	int si_signo;
	int si_errno;
	int si_code;
	int __pad0;

What's wrong with that?

	--david
