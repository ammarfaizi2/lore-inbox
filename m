Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131060AbQL1G3R>; Thu, 28 Dec 2000 01:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbQL1G3H>; Thu, 28 Dec 2000 01:29:07 -0500
Received: from tantalophile.demon.co.uk ([193.237.65.219]:16134 "EHLO
	thefinal.cern.ch") by vger.kernel.org with ESMTP id <S131060AbQL1G26>;
	Thu, 28 Dec 2000 01:28:58 -0500
Date: Thu, 28 Dec 2000 06:50:20 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Al Peat <al_kernel@yahoo.com>
Cc: linux-kernel@vger.kernel.org, myself <al_peat@yahoo.com>,
        Juri Haberland <juri.haberland@innominate.com>
Subject: Re: Purging the Page Table (was: Purging the Buffer Cache)
Message-ID: <20001228065020.B4578@thefinal.cern.ch>
In-Reply-To: <20001222011652.30206.qmail@web10101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001222011652.30206.qmail@web10101.mail.yahoo.com>; from al_kernel@yahoo.com on Thu, Dec 21, 2000 at 05:16:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Peat wrote:
> > >   Is there any way to completely purge the buffer
> > > cache -- not just the write requests (ala 'sync'
> > or
> > > 'update'), but the whole thing?  Can I just call
> > > invalidate_buffers() or destroy_buffers()?

Try this script:

case "`id -u`" in
  0) ;;
  *) echo Only root can run this script. 1>&2; exit 1 ;;
esac

mount | sort -k3 -r | \
while read dev ON dir TYPE type etc; do
  echo mount $dir -o remount
  mount $dir -o remount
done

mount | sort -k1 | \
while read dev ON dir TYPE type etc; do
  case "$dev" in
    /dev/*) echo hdparm -f $dev
      hdparm -f $dev >/dev/null ;;
  esac
done

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
