Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbTACBLe>; Thu, 2 Jan 2003 20:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267367AbTACBLe>; Thu, 2 Jan 2003 20:11:34 -0500
Received: from crack.them.org ([65.125.64.184]:16065 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267417AbTACBLd>;
	Thu, 2 Jan 2003 20:11:33 -0500
Date: Thu, 2 Jan 2003 20:20:11 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [OT] For those who want From: lines on bk-commits-* mail
Message-ID: <20030103012011.GA7706@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mentioned this when the list was first set up; the decision seemed to be
that using a fixed From: line was more polite to people who hadn't
volunteered to have their email addresses archived, or more likely to put
discussions in the right place, or other things along those lines.  Well,
for those who would prefer to look at a mailbox summary and know who commits
came from, here's a simple way to do it.  I'm sure someone on the list can
find a more elegant solution.

.procmailrc:
:0
* ^X-Mailing-List:.*bk-commits-head@
{
  :0f
  | $HOME/bin/set-from.sh

  :0 :
  bk-commits-head/
}

set-from.sh:
#!/bin/sh

cat > $HOME/.tmp/bk-head-tmp.$$

from=`grep '^ChangeSet' $HOME/.tmp/bk-head-tmp.$$ | head -1 | awk '{print $NF}'`
if test -n "$from"; then
 formail -i "From: $from" < $HOME/.tmp/bk-head-tmp.$$
else
 cat $HOME/.tmp/bk-head-tmp.$$
fi

rm $HOME/.tmp/bk-head-tmp.$$


Just mkdir $HOME/.tmp before trying this.  The tmpdir handling is blatantly
unsafe, so I don't recommend using /tmp.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
