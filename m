Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287850AbSABPsM>; Wed, 2 Jan 2002 10:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287847AbSABPsC>; Wed, 2 Jan 2002 10:48:02 -0500
Received: from sunsite.ms.mff.cuni.cz ([195.113.19.66]:38919 "EHLO
	sunsite.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S287850AbSABPrz>; Wed, 2 Jan 2002 10:47:55 -0500
Date: Wed, 2 Jan 2002 16:50:13 +0100
From: Jakub Jelinek <jakub@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102165013.A1602@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net> <87ital6y5r.fsf@fadata.bg> <20020102153920.GA1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20020102153920.GA1803@cpe-24-221-152-185.az.sprintbbd.net>; from Tom Rini on Wed, Jan 02, 2002 at 08:39:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 08:39:20AM -0700, Tom Rini wrote:
> Well, Paulus wrote 'strcpy' not 'memcpy', so why does gcc get to assume
> it's safe to change it?  In this case it's certainly not.

But unless you trigger undefined behaviour, strcpy(x, "foobar" + n) is
equal to memcpy(x, "foobar" + n, sizeof("foobar") - n); and the latter is
more efficient (you don't have to check for end-of-string during copying).

> > It is not a workaround, it is a fix to an invalid code, which gets
> > triggered by particular optimization.
> 
> By a particular optimization that's not present before gcc-3.0, and
> happens to break things under some conditions, as you've seen.

It just happens to do a different thing than it used to when seeing code
with particular case of undefined behaviour.

	Jakub
