Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbQKTXnf>; Mon, 20 Nov 2000 18:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbQKTXnZ>; Mon, 20 Nov 2000 18:43:25 -0500
Received: from smtp5.libero.it ([193.70.192.55]:60073 "EHLO smtp5.libero.it")
	by vger.kernel.org with ESMTP id <S129638AbQKTXnU>;
	Mon, 20 Nov 2000 18:43:20 -0500
Message-ID: <3A19B00A.C9D98839@libero.it>
Date: Tue, 21 Nov 2000 00:13:14 +0100
From: Abramo Bagnara <abramo.bagnara@libero.it>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Michal Jaegermann <michal@harddata.com>
CC: linux-kernel@vger.kernel.org, akenning@dog.topology.org
Subject: Re: easy-to-fix bug in /dev/null driver
In-Reply-To: <20001120160638.A14325@dog.topology.org> <20001121005304.A15760@dog.topology.org> <20001120123300.A19251@mail.harddata.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann wrote:
> 
> On Tue, Nov 21, 2000 at 12:53:04AM +1030, Alan Kennington wrote:
> >
> > I still think that write_null() should be rewritten as:
> >
> > ===================================================
> > static ssize_t write_null(struct file * file, const char * buf,
> >                           size_t count, loff_t *ppos)
> > {
> >         return (count <= 2147483647) ? count : 2147483647;
> > }
> > ===================================================
> >
> > This would fix the problem without introducing any new errors.
> > (Unless someone change the definitions of ssize_t and size_t!!)
> 
> Someone already did.  Or, more precisely, there are platforms where
> values used in 'return' above are bogus.
> 
> Shifting 1 up by sizeof(ssize_t) * 8 - 1 and subtracting one from
> the result, in order to derive the maximal allowable value, might work.
> I do not think that we have anything with non-8 bit bytes yet.
> 

I think it's time to provide SIZE_MAX and SSIZE_MAX along with
size_t/ssize_t typedefs.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
