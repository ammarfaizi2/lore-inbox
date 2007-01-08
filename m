Return-Path: <linux-kernel-owner+w=401wt.eu-S1030534AbXAHEme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030534AbXAHEme (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbXAHEme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:42:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40721 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030534AbXAHEmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:42:33 -0500
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20070107200553.GA15101@redhat.com>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
	 <1168182838.14763.24.camel@shinybook.infradead.org>
	 <20070107153833.GA21133@flint.arm.linux.org.uk>
	 <20070107182151.7cc544f3@localhost.localdomain>
	 <20070107191730.GD21133@flint.arm.linux.org.uk>
	 <20070107200553.GA15101@redhat.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jan 2007 12:42:36 +0800
Message-Id: <1168231356.14763.176.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 15:05 -0500, Dave Jones wrote:
> This has been bugging me for a while.
> Viewing the mail I applied in mutt shows his name correctly as Rafał
> Applying it with git-applymbox and viewing the log on master.kernel.org
> with git log shows Rafa<B3>   And then later when put into email
> it turns into Rafa³ 

I believe you need to use the misnamed '-u' option to git-applymbox,
which _really_ ought to be the default behaviour. Otherwise, it fails to
pay any attention to the character set tags in the mail it's decoding --
it commits the sin which rmk was whining about; assuming the input data
is of a given type and ignoring the explicit tags which indicate the
contrary.

The '-u' option is misdocumented as 'causes the resulting commit to be
encoded in utf-8', but in fact I believe it doesn't necessarily do that
-- it actually causes the resulting commit to be encoded in the
configured storage charset for the repository, which just _happens_ to
default to UTF-8 unless otherwise specified. That is something which
should definitely be the _default_ behaviour.

We should make the '-u' behaviour the default, and if anyone really
wants the old behaviour of importing arbitrary data in untagged 
binary form overriding its labelling then they can have a separate
option which does that.

-- 
dwmw2

