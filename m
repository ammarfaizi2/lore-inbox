Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbSJFQP0>; Sun, 6 Oct 2002 12:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261674AbSJFQOr>; Sun, 6 Oct 2002 12:14:47 -0400
Received: from [195.223.140.120] ([195.223.140.120]:22066 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261515AbSJFQOM>; Sun, 6 Oct 2002 12:14:12 -0400
Date: Sun, 6 Oct 2002 18:20:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: partly solved IO performance problems in 2.5.40 when writing to DVD-RAM/ZIP
Message-ID: <20021006162012.GD32733@dualathlon.random>
References: <rxx8z1bim8v.fsf@synapse.t30.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxx8z1bim8v.fsf@synapse.t30.physik.tu-muenchen.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 06:08:00PM +0200, Moritz Franosch wrote:
> Theoretically, the two devices (e.g. the 120 GB HDD and the DVD-RAM in
> nr. 2) are independent (at least when they are on a different IDE
> controller), so the read should perform as good as without the
> additional writing activity (31 seconds, as given in the column
> "expected"). But in reality the read takes 1.8 times as long. With
> 2.4.50, there could be performance gains up to a factor of 2.4 (test
> nr. 4). But that's _much_ better than 2.4.19-pre5 where performance
> gains of up to a factor of 14 (test nr. 2) were possible.

one of the reasons 2.5 works better is that it has more than one bdflush
thread (aka pdflush), so it can submit in parallel to all your storages
and you don't risk to hang on writes on the very slow device, despite
your main harddisk could be completely idle. This isn't easily fixable
in 2.4, it's one of the things 2.5 is there for ;)

Andrea
