Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSJYQcr>; Fri, 25 Oct 2002 12:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSJYQcr>; Fri, 25 Oct 2002 12:32:47 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:64773 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP
	id <S261476AbSJYQcp>; Fri, 25 Oct 2002 12:32:45 -0400
Message-Id: <5.1.0.14.0.20021025091912.01d986d0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 25 Oct 2002 09:38:54 -0700
To: Daniel Egger <degger@fhm.edu>, hps@intermeta.de
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: One for the Security Guru's
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1035500731.439.4.camel@sonja.de.interearth.com>
References: <ap8fjq$8ia$1@forge.intermeta.de>
 <20021023130251.GF25422@rdlg.net>
 <1035411315.5377.8.camel@god.stev.org>
 <ap8fjq$8ia$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:28 PM 10/25/02 +0200, Daniel Egger wrote:
>Don't laugh; I had such a box reinstalled from ground just the day
>before yesterday because I found a RedHat full Install on it. Not to
>mention that there're "admins" out there who use GNOME as root on a
>fairly busy mailserver <shudder>...

I'm not laughing, I inherited a firewall box that had a full install of Red 
Hat 7.1, complete with GUI.  I got the network information, loaded up 7.3 
with minimal installation, and cleaned up that "minimal install" by using 
"rpm -qa" (it's your friend) to identify and rid the system of every single 
package not necessary to the operation of a firewall.

GCC.  PERL.  Sendmail (!). The eight different version of FTP.  (I may be 
exaggerating, but the stream of packages that offer FTP client and server 
services seems to be endless.)  Things that a root kit would find extremely 
useful to install back doors and other nasties.  Debuggers.  Those were 
just the extra packages -- I also scanned for unnecessary SUID binaries 
when I was finished and blasted them to the ol' game grid.

I then used IPTABLES to implement the security policy of the client, and 
part of that policy was that the only packets that were allowed to talk 
directly  to the firewall was SSH, and only from my range of IP addresses, 
and ping from anywhere...and I rate-limited the ping to 10 per second so 
that a ping flood would not hose the return channel.

Incoming SYN requests to the firewall (except for SSH directed to the 
firewall) are alway dropped silently, and the vast majority of UDP packets 
also find their way to the bit bucket.  Oddball TCP attacks (the log showed 
a LAMP-TEST packet attack last week) are also given the heave-ho.  I have 
NAT in the outgoing direction, and only those ports necessary to the 
operation of the client are open.  That means no ICQ, at all, for 
example.  No streaming audio.  And, as you can guess, no outbound 
connections are accessible to the likes of BackOrfice.

I'm sure there is a hole somewhere in that firewall box, but I have plugged 
all the ones I found documented on CERT.

Oh, and a low-volume Web server was moved off the firewall and onto a 
separate box, with the firewall forwarding packet traffic via IPTABLES rules.

