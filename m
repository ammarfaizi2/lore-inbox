Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRATWkb>; Sat, 20 Jan 2001 17:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbRATWkL>; Sat, 20 Jan 2001 17:40:11 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:53262 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S129780AbRATWkJ>; Sat, 20 Jan 2001 17:40:09 -0500
Message-ID: <3A6A13B2.1F4737E2@psychosis.com>
Date: Sat, 20 Jan 2001 17:39:46 -0500
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
Organization: www.psychosis.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1p8-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sandy Harris <sandy@storm.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: md= broken. Found problem. Can't fix it.  : (
In-Reply-To: <3A6A044F.7974AF67@psychosis.com> <3A6A0A20.18362B90@storm.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy Harris wrote:
> Looks to me like this parsing code unnecessarily and rather clumsily 
> re-invents strtok

The original parsing code is this:
		if ((str = strchr(str, ',')) != NULL)
			str++;
Which effectivly steps through
		/dev/sda1,/dev/sdab1,/dev/sdc1
like this
		str == /dev/sda1,/dev/sdab1,/dev/sdc1
		str == /dev/sdab1,/dev/sdc1
		str == /dev/sdc1

My code:	char *ndevstr;
		ndevstr = strchr(str, ',');
		if (ndevstr != NULL)	*ndevstr++ = 0;	
		...
		str = ndevstr

Works perfectly. I don't find it 'clumsy' or more complex at all. (I don't care
for strtok, nor did I even know the kernel had it)


However I don't see this critique of coding style helping the problem I'm
seeing:

	name_to_kdev_t(str);
Returns a bad value. Yet
	name_to_kdev_t("/dev/sdd5");
does not. The strange thing is
	printk("Checking: '%s'\n", str);
shows str does infact contain a proper string.

It appears str does not get passed to name_to_kdev_t() properly,
and I have no idea why. Both my testing code and the original code
exhibit the same problem.


-- 
"Nobody will ever be safe until the last cop is dead."
		NH Rep. Tom Alciere - (My new Hero)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
