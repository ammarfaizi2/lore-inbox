Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbUAFR2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUAFR2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:28:30 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:50802 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264901AbUAFR21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:28:27 -0500
Subject: [OT] Re: udev and devfs - The final word
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200401051814.08409.rob@landley.net>
References: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
	 <20040105201144.GA11179@thunk.org> <20040105210625.GA26428@ucw.cz>
	 <200401051814.08409.rob@landley.net>
Content-Type: text/plain
Message-Id: <1073410115.31890.7.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 12:28:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 19:14, Rob Landley wrote:
> You can run any tcp/ip service over ssh.
> 
> Yeah, the script's a quick and dirty hack, but really easy to modify.  I have 
> a more complicated one using SO_ORIGINAL_DEST and a lookup table if you 
> prefer to setup some firewall rules and tell your imap server it lives in the 
> 192.168.x.x or 10.x.x.x address range...  But I've never gotten around to 
> configuring my laptop to use it just to tunnel pop. :)

simpler:
ssh -L<local>:127.0.0.1:<remote> [-C] user@host

eg I forward imap from home (not accessible outside localhost) and
jabber from a second machine at home:
ssh -L143:localhost:143 -L5222:jabber:5222 -C dis@home

Then just point the client at localhost:143 (or 5222) and it 'just
works'. No python required. 

For an added bonus, run a script on the far side that does something
like:
 while /bin/true; do 
    if [ -f .dienow ]; then 
      rm -f .dienow
      exit
    else sleep 60
  done
and on the local side:
 while /bin/true; do 
   ssh -L1:localhost:2 etc user@host ./remotescript 
   sleep 1
   if [ -f .dienow ]; do 
     scp .dienow user@host: && rm -f .dienow
   done
  done

..respawn the ssh forwards until it finds ~/.dienow (-and- the current
ssh exits) and then kill off both sides.  Don't flood the system by
respawning ssh more than once per 1-2 seconds. (And who said you
couldn't vpn with shell? You can even add/remove ports along the way, if
you get creative.)

-- 
Disconnect <lkml@sigkill.net>

