Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUHRM3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUHRM3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUHRM3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:29:22 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:16103
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266201AbUHRM1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:27:23 -0400
Message-ID: <41234B2A.7040507@bio.ifi.lmu.de>
Date: Wed, 18 Aug 2004 14:27:22 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: andreas.messer@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net>	<20040816231211.76360eaa.Ballarin.Marc@gmx.de>	<4121A689.8030708@bio.ifi.lmu.de>	<200408171311.06222.satura@proton>	<20040817155927.GA19546@proton-satura-home>	<41234500.5080500@bio.ifi.lmu.de> <20040818142046.36499779.Ballarin.Marc@gmx.de>
In-Reply-To: <20040818142046.36499779.Ballarin.Marc@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Marc Ballarin wrote:

> growisofs and dvd+r-format open the device read-only, even though they try
> to do writes.
> 
> Two choices:
> 1) declare all needed commands as safe for read 

yes, that's what I tried, but it had no effect. For instance, I declared

                safe_for_read(GPCMD_READ_FORMAT_CAPACITIES),

which is 0x23, but growisofs still complains with

Aug 18 13:52:21 aiken kernel: THIS IS MY NEW PATCH SCSI-CMD Filter: 0x23 not allowed with read-mode

That's what I don't understand. I think the line above should declare
0x23 as safe for read, but it seems to be ignored.

 > (you might as well disable filtering completely...)

Likely I will end up with this :-/


> 
> 2) replace O_RDONLY in dvd+r-tools sources with O_RDWR and recompile
> (that's what I did).

I will check that!

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

