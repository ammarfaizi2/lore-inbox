Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbRB1RTq>; Wed, 28 Feb 2001 12:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130274AbRB1RTh>; Wed, 28 Feb 2001 12:19:37 -0500
Received: from [199.239.160.155] ([199.239.160.155]:28175 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S130271AbRB1RTZ>; Wed, 28 Feb 2001 12:19:25 -0500
Date: Wed, 28 Feb 2001 09:18:59 -0800
From: Robert Read <rread@datarithm.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] set kiobuf io_count once, instead of increment
Message-ID: <20010228091859.A9540@tenchi.datarithm.net>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010227162222.A6389@tenchi.datarithm.net> <Pine.LNX.4.21.0102272234380.7124-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0102272234380.7124-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Feb 27, 2001 at 10:50:54PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 10:50:54PM -0300, Marcelo Tosatti wrote:
> 
> 
> It seems your patch breaks bh allocation failure handling. If
> get_unused_buffer_head() fails, iobuf->io_count never reaches 0, so
> processes waiting on kiobuf_wait_for_io() will block forever.
> 

This is true, but it looks like the brw_kiovec allocation failure
handling is broken already; it's calling __put_unused_buffer_head on
bhs without waiting for them to complete first.  Also, the err won't
be returned if the previous batch of bhs finished ok.  It looks like
brw_kiovec needs some work, but I'm going to need some coffee first...


robert
