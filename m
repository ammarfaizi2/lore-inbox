Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSD0UYh>; Sat, 27 Apr 2002 16:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314463AbSD0UYh>; Sat, 27 Apr 2002 16:24:37 -0400
Received: from bstnma1-ar1-4-64-205-250.bstnma1.elnk.dsl.genuity.net ([4.64.205.250]:36822
	"EHLO mail.spoofed.org") by vger.kernel.org with ESMTP
	id <S314459AbSD0UYg>; Sat, 27 Apr 2002 16:24:36 -0400
Date: Sat, 27 Apr 2002 16:27:56 -0400
From: Warchild <warchild@spoofed.org>
To: linux-kernel@vger.kernel.org
Subject: remote memory reading using arp?
Message-ID: <20020427202756.GC6240@spoofed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greetings,

While doing some work earlier today, I happened to have a window open on my
(Slackware 8) 2.4.16 box with tcpdump running.  Since I really wasn't doing
anything on the laptop the only traffic that was flying by via tcpdump was
the occassional ntp sync and some arp traffic here and there.

Out of the corner of my eye, I happened to notice something that seemed
very out of place -- human readable text included as part of the arp
packet.  Ok, so maybe the chances of that aren't _that_ slim, but the text
was familiar to me.  To see if this was just a one time thing or not, I
fired up tcpdump and told it to capture all arp traffic (tcpdump -ni eth0
-w /tmp/arp arp).  I did this 3 times while browsing the web, scp'ing stuff
around and screwing around on my laptop.  

I then replayed the tcpdump sessions and used the -X option (dumps the
packet in emacs-hexl like format), piped them to less and looked for
anything suspicous.  Here's some examples of what I found:

(pardon the paste)

15:20:09.186852 0:40:96:15:16:4f ff:ff:ff:ff:ff:ff 0806 60: arp who-has
192.168.1.1 tell 192.168.1.2
  0000: 0001 0800 0604 0001 0040 9615 164f c0a8  .........@...O¿®
  0010: 0102 0000 0000 0000 c0a8 0101 652f 656e  ........¿®..e/en
  0020: 6c69 6768 7465 6e6d 656e 742f 7468       lightenment/th


15:20:11.187501 0:6:25:3:ce:65 0:40:96:15:16:4f 0806 60: arp reply
192.168.1.1 is-at 0:6:25:3:ce:65
  0000: 0001 0800 0604 0002 0006 2503 ce65 c0a8  ..........%.Œe¿®
  0010: 0101 0040 9615 164f c0a8 0102 6874 656e  ...@...O¿®..hten
  0020: 6d65 6e74 2f74 6865 6d65 732f 4761       ment/themes/Ga

15:20:12.186895 0:40:96:15:16:4f ff:ff:ff:ff:ff:ff 0806 60: arp who-has
192.168.1.1 tell 192.168.1.2
  0000: 0001 0800 0604 0001 0040 9615 164f c0a8  .........@...O¿®
  0010: 0102 0000 0000 0000 c0a8 0101 705f 632e  ........¿®..p_c.
  0020: 706e 670a 2f75 7372 2f58 3131 5236       png./usr/X11R6
 
15:00:55.970007 0:6:25:3:ce:65 0:40:96:15:16:4f 0806 60: arp reply
192.168.1.1 is-at 0:6:25:3:ce:65
  0000: 0001 0800 0604 0002 0006 2503 ce65 c0a8  ..........%.Œe¿®
  0010: 0101 0040 9615 164f c0a8 0102 6574 2d31  ...@...O¿®..et-1
  0020: 2e30 2e32 612f 6269 6e2f 0500 0000       .0.2a/bin/....


15:03:07.290878 0:6:25:3:ce:65 0:40:96:15:16:4f 0806 60: arp reply
192.168.1.1 is-at 0:6:25:3:ce:65
  0000: 0001 0800 0604 0002 0006 2503 ce65 c0a8  ..........%.Œe¿®
  0010: 0101 0040 9615 164f c0a8 0102 0d00 1d00  ...@...O¿®......
  0020: 696e 6572 4861 6e64 6c65 722e 6874       inerHandler.ht


192.168.1.2 is a Slackware 8 box with 2.4.16, and 192.168.1.1 is an OpenBSD
3.1-current box.  It struck me as extremely strange that the contents of
the arp packets contained information about my laptop.   To ensure that
this wasn't just tcpdump acting dumb, I left tcpdump running while I wasn't
doing anything on the laptop at all.  I got similar results.  

I couldn't find anything in the archives about this, and also didn't see
any changes in the arp implementation of the 2.4 kernel between 2.4.16 and
2.4.18.  I also browsed rfc826 to see if there was any mention of 'padding
data', but nothing caught my eye.

Any ideas what is causing this?

thanks in advance,

-warchild
