Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284304AbSABViE>; Wed, 2 Jan 2002 16:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284472AbSABVhy>; Wed, 2 Jan 2002 16:37:54 -0500
Received: from dot.cygnus.com ([205.180.230.224]:60938 "HELO dot.cygnus.com")
	by vger.kernel.org with SMTP id <S284304AbSABVhr>;
	Wed, 2 Jan 2002 16:37:47 -0500
Date: Wed, 2 Jan 2002 13:36:32 -0800
From: Richard Henderson <rth@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102133632.C10362@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
	Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 12:09:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 12:09:10PM -0700, Tom Rini wrote:
> 2) Add -ffreestanding to the CFLAGS of arch/ppc/kernel/prom.o (If this
> optimization comes back on with this flag later on, it would be a
> compiler bug, yes?)

No.  You still have the problem of using pointer arithmetic past
one past the end of the object.

C99 6.5.6/8:

   If both the pointer operand and the result point to elements of the
   same array object, or one past the last element of the array object,
   the evaluation shall not produce an overflow; otherwise, the behavior
   is undefined.


r~
