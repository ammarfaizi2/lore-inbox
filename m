Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSBSSfv>; Tue, 19 Feb 2002 13:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSBSSfr>; Tue, 19 Feb 2002 13:35:47 -0500
Received: from zok.sgi.com ([204.94.215.101]:55190 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S286687AbSBSSf2>;
	Tue, 19 Feb 2002 13:35:28 -0500
Date: Tue, 19 Feb 2002 10:35:06 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Collins <bcollins@debian.org>
Subject: Re: readl/writel and memory barriers
Message-ID: <20020219103506.A1511175@sgi.com>
Mail-Followup-To: David Mosberger <davidm@hpl.hp.com>,
	Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ben Collins <bcollins@debian.org>
In-Reply-To: <092401c1b8e7$1d190660$1a01a8c0@allyourbase> <15474.34580.625864.963930@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15474.34580.625864.963930@napali.hpl.hp.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 09:10:44AM -0800, David Mosberger wrote:
> On ia64, the fact that readl()/writel() are accessing uncached space
> ensures the CPU doesn't reorder the accesses.  Furthermore, the
> accesses are performed through "volatile" pointers, which ensures that
> the compiler doesn't reorder them (and, as a side-effect, such
> pointers also generate ordered loads/stores, but this isn't strictly
> needed, due to accessing uncached space).

Making a variable volatile doesn't guarantee that the compiler won't
reorder references to it, AFAIK.  And on some platforms, even uncached
I/O references aren't necessarily ordered.

To avoid the overhead of having I/O flushed on every memory barrier
and readX/writeX operation, we've introduced mmiob() on ia64, which
explicity orders I/O space accesses.  Some ports have chosen to take
the performance hit in every readX/writeX, memory barrier, and
spinlock however (e.g. PPC64, MIPS).

Is this a reasonable approach?  Is it acceptable to have a seperate
barrier operation for I/O space?  If so, perhaps other archs would be
willing to add mmiob() ops?

Thanks,
Jesse
