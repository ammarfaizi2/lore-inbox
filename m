Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTKQVs6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTKQVs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:48:58 -0500
Received: from mx5.Informatik.Uni-Tuebingen.De ([134.2.12.32]:13959 "EHLO
	mx5.informatik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S262041AbTKQVsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:48:53 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: alpha@steudten.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Re: BUG: Kernel Panic: kernel-2.6.0-test9-bk21  for alpha in scsi context ll_rw_blk.c
References: <3FB92938.8040906@steudten.com>
	<87r806d6n6.fsf@student.uni-tuebingen.de> <3FB93EF6.807@steudten.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 17 Nov 2003 22:48:49 +0100
In-Reply-To: <3FB93EF6.807@steudten.com>
Message-ID: <87islid5tq.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Steudten <alpha@steudten.com> writes:

> On http://steudten.com/alpha/perf.php4 you can read:
> See prefetch section:
> The Alpha 21264 initiates a prefetch operation by executing one of the
> load instructions as summarized in the table below. Note that the
> destination register is R31 or F31. When used as a source register,
> R31 and F31 return integer zero and floating point zero,
> respectively. When used as a destination register as shown below, R31
> and F31 denote the purpose of these instructions as a prefetch
> operation. Earlier Alpha implementations ignore these
> instructions. Some care must be taken as a prefetch with an invalid
> address must be dismissed by firmware and a prefetch can cause an
> alignment trap.

Well, the architecture manual requires these instructions have no
visible effect whatsoever, i. e. they never trap. It seems sensible to
me to enforce this also in kernel space, since this is what gcc
assumes.

-- 
	Falk
