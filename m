Return-Path: <linux-kernel-owner+w=401wt.eu-S1751058AbXACTPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbXACTPy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbXACTPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:15:53 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:60107 "EHLO
	janus.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbXACTPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:15:53 -0500
X-Greylist: delayed 1056 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 14:15:52 EST
Date: Wed, 3 Jan 2007 19:58:15 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Pavel Machek <pavel@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
Message-ID: <20070103185815.GA2182@janus>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <20061229100223.GF3955@ucw.cz> <Pine.LNX.4.64.0701012333380.5162@artax.karlin.mff.cuni.cz> <20070101235320.GS8104@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0701020055580.32128@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701020055580.32128@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 01:04:06AM +0100, Mikulas Patocka wrote:
> 
> I didn't hardlink directories, I just patched stat, lstat and fstat to 
> always return st_ino == 0 --- and I've seen those failures. These failures 
> are going to happen on non-POSIX filesystems in real world too, very 
> rarely.

I don't want to spoil your day but testing with st_ino==0 is a bad choice
because it is a special number. Anyway, one can only find breakage,
not prove that all the other programs handle this correctly so this is
kind of pointless.

On any decent filesystem st_ino should uniquely identify an object and
reliably provide hardlink information. The UNIX world has relied upon this
for decades. A filesystem with st_ino collisions without being hardlinked
(or the other way around) needs a fix.

Synthetic filesystems such as /proc are special due to their dynamic
nature and I think st_ino uniqueness is far more important than being able
to provide hardlinks there. Most tree handling programs ("cp", "rm", ...)
break horribly when the tree underneath changes at the same time.

-- 
Frank
