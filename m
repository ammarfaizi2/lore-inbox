Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbRBRSaN>; Sun, 18 Feb 2001 13:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130669AbRBRSaD>; Sun, 18 Feb 2001 13:30:03 -0500
Received: from coruscant.franken.de ([193.174.159.226]:1808 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S130420AbRBRS3q>; Sun, 18 Feb 2001 13:29:46 -0500
Date: Sun, 18 Feb 2001 19:29:42 +0100
From: Harald Welte <laforge@gnumonks.org>
To: jbwan@home.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: too long mac address for --mac-source netfilter option
Message-ID: <20010218192942.C17431@coruscant.gnumonks.org>
In-Reply-To: <20010217014042.CDAY585.mail2.rdc2.bc.home.com@nonesuch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010217014042.CDAY585.mail2.rdc2.bc.home.com@nonesuch.localdomain>; from jbinpg@home.com on Fri, Feb 16, 2001 at 05:40:04PM -0800
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Boomtime, the 47th day of Chaos in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2001 at 05:40:04PM -0800, Jack Bowling wrote:
> I am trying to use the --mac-source option in the netfilter code to better
> refine access to my linux box. However, I have run up against something. The
> router through which my private subnet work box passes sends a 14-group
> "invalid" mac address, presumably as an attempt to conceal the real hextile
> mac address. However, the code for the --mac-source netfilter option is
> looking for a valid hextile mac address and complains loudly as such
> (numerals converted to x's): 
> 
> iptables v1.1.1: Bad mac address `xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx'
> 
> to the respective iptable line:
> 
> $IPT -A INPUT -p tcp -s xxx.xxx.xxx.xxx -d $NET -m mac --mac-source
> xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx --dport 5900:5901 -j ACCEPT 
> 
> The idea here is to allow VNC access to my home box with the access filtered
> by both IP and mac address.

This is not a bug. It is by intention. The LOG target (as well as the 
ULOG target from netfilter CVS) prints the whole layer two header.

6 bytes mac-source, 6 bytes mac-destination and 2 bytes (08:00) indicating
it is IP. == 14 bytes :)

On the other hand, the --mac-source match (emphasized mac-SOURCE) allows
you to match on the source part of this mac header (i.e. the first 6 bytes)

> Jack Bowling
> mailto: jbinpg@home.com

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
