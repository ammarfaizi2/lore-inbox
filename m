Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263692AbUFFOk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbUFFOk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 10:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUFFOk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 10:40:26 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:6793 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263692AbUFFOkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 10:40:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6] Mousedev - better button handling under load
Date: Sun, 6 Jun 2004 09:40:20 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200406050249.02523.dtor_core@ameritech.net> <20040606095843.GC1646@ucw.cz>
In-Reply-To: <20040606095843.GC1646@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406060940.21209.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 June 2004 04:58 am, Vojtech Pavlik wrote:
> On Sat, Jun 05, 2004 at 02:49:00AM -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > Currently mousedev combines all hardware motion data that arrivers since
> > last time userspace read data into one cooked PS/2 packet. The problem is
> > that under heavy or even moderate load, when userspace can't read data
> > quickly enough, we start loosing valuable data which manifests in:
> > 
> > - ignoring buton presses as by the time userspace gets to read the data
> >   button has already been released;
> > - click starts in wrong place - by the time userspace got aroungd and read
> >   the packet mouse moved half way across the screen.
> > 
> > The patch below corrects the issue - it will start accumulating new packet
> > every time userspace is behind and button set changes. Size of the buffer
> > is 16 packets, i.e. up to 8 pairs of press/release events which should be
> > more than enough.
> > 
> > The patch is against Vojtech's tree and shuld apply to -mm. I also have
> > cumulative mousedev patch done against 2.6.7-pre2 at:
> > 
> > http://www.geocities.com/dt_or/input/misc/mousedev-2.6.7-rc2-cumulative.patch.gz
> 
> Thanks for this. Can I just pull from your tree, or is there more that I
> shouldn't take?
> 

I am exporting stuff to my bk tree on as-needed basis so there is nothing
extra (and no mousedev changes yet). Do you want button handling changes
only or you do also want tapping emulation exported?

-- 
Dmitry
