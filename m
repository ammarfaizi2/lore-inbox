Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272651AbRIXVa1>; Mon, 24 Sep 2001 17:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272576AbRIXVaR>; Mon, 24 Sep 2001 17:30:17 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:39883 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S272636AbRIXVaE>; Mon, 24 Sep 2001 17:30:04 -0400
Date: Mon, 24 Sep 2001 17:30:29 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Simon Kirby <sim@netnation.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: O_NONBLOCK on files
Message-ID: <20010924173029.J17683@redhat.com>
In-Reply-To: <20010918234648.A21010@netnation.com> <m1r8t3fyot.fsf@frodo.biederman.org> <20010919002439.A21138@netnation.com> <20010924234717.V11046@mea-ext.zmailer.org> <20010924140534.E2335@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010924140534.E2335@netnation.com>; from sim@netnation.com on Mon, Sep 24, 2001 at 02:05:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 02:05:34PM -0700, Simon Kirby wrote:
> Yes, but this sucks.  My whole intent was an interface design that would
> never need to context switch.  I'm not sure if this is even possible, but
> if so it would be very nice from a userspace perspective.

Actually, this was one of the design concerns that I had in coming up with 
the async io interfaces.  The interface was designed to make use of the 
upcoming syscalls-in-userspace stubs that x86-64 implemented and will be 
passed on to x86 in 2.5.  All completion events are passed through a ring 
buffer with minimal locking on the kernel side which only needs thread 
locking in userspace.  This way the whole userspace to kernel transition 
can be avoided by the server under sufficiently high load.

		-ben
