Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313299AbSC1X2R>; Thu, 28 Mar 2002 18:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313300AbSC1X2H>; Thu, 28 Mar 2002 18:28:07 -0500
Received: from zoon.lafn.org ([206.117.18.9]:27973 "EHLO zoon.lafn.org")
	by vger.kernel.org with ESMTP id <S313299AbSC1X1u>;
	Thu, 28 Mar 2002 18:27:50 -0500
Date: Thu, 28 Mar 2002 13:39:43 -0800
From: David Lawyer <dave@lafn.org>
To: Ed Vance <EdV@macrolink.com>
Cc: "'Henrique Gobbi'" <henrique@cyclades.com>, linux-kernel@vger.kernel.org,
        "'linux-serial'" <linux-serial@vger.kernel.org>
Subject: Re: Char devices drivers
Message-ID: <20020328133942.A446@lafn.org>
Mail-Followup-To: David Lawyer <dave>, Ed Vance <EdV@macrolink.com>,
	'Henrique Gobbi' <henrique@cyclades.com>,
	linux-kernel@vger.kernel.org,
	'linux-serial' <linux-serial@vger.kernel.org>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76EC@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 09:59:14AM -0800, Ed Vance wrote:
> On Mon, Mar 11, 2002, Henrique Gobbi wrote:
> > 
> > Can anyone explain what is the utility of the callout devices 
> > in the char drivers ???
> 
> To further confuse things, most vendors have a "back door" port
> configuration mechanism outside of termio(s)/sgtty. For example, Linux has
> the setserial command. There is less need for separate callout devices when
> the user can set a port to open with the desired flag values.

Setserial doesn't have facilities to set open flags for the ports.  The
reason cua isn't needed is that the programmer can make a ttyS port look
like a cua port by using the O_NONBLOCK or O_NDELAY flags.  However the
non-blocking flag will not only force an open when CD is asserted, but
will make all reads of the port non-blocking.  So the programmer can
change this if he wants after the port has opened.

So eliminating cua means more work for the programmer but less confusion
for users.  Overall, it's a good thing since there are many more users
than programmers.

			David Lawyer
