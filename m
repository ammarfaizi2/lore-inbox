Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUDRFv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUDRFv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:51:28 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:35335 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S264134AbUDRFv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:51:27 -0400
Date: Sun, 18 Apr 2004 07:51:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Ian Morgan <imorgan@webcon.ca>
Cc: helpdeskie@bencastricum.nl, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.5 Sensors & USB problems
Message-Id: <20040418075140.6c118202.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.58.0404171944160.11425@dark.webcon.ca>
References: <1081349796.407416a4c3739@imp.gcu.info>
	<Pine.LNX.4.58.0404171756400.11374@dark.webcon.ca>
	<Pine.LNX.4.58.0404171944160.11425@dark.webcon.ca>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems that the w83781d driver no longer detects whatever the sensor
> chip on the P4PE is, but I see there is now a new driver called asb100
> which does work. An old conflicting lm_sensors install was breaking
> the sensors-detect script, but once resolved it nicely detected the
> asb100.

The hardware monitoring chip on the P4PE is an Asus ASB100 "Bach". It
used to be somewhat supported by the w83781d driver (see as an
"as99127f" kind) but then a new, dedicated driver was developed by Mark
M. Hoffman, which works better. For this reason, support was dropped
from the w83781d, which explains why it suddenly stopped working.

I agree that this should have been advertised a little more, and I am
adding information about this on our 2.6 kernel dedicated page at the
moment.

> Can anyone explain, however, why my i2c bus showed up as number 0
> under linux <= 2.6.4, and now always as number 1 under linux 2.6.5?
> The is no number 0 any more.

The bus number allocation scheme is such that once a number has been
used once (since the machine last booted) it will not be used again.
This is admittedly not ideal and should be fixed. I suspect that the fix
isn't trivial because the current structures would make the new scheme
have a poor algorithmic complexity (O(2) maybe), but I haven't checked
yet. Greg, can you confirm?

This isn't critical (unless you cycle your i2c adapter drivers a great
number of times, but nodoby does this) which is why no attempt has been
made to fix it yet. Anyone with a nice fix is welcome however ;)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
