Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279717AbRJ3BRS>; Mon, 29 Oct 2001 20:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279716AbRJ3BRJ>; Mon, 29 Oct 2001 20:17:09 -0500
Received: from pD9E39903.dip.t-dialin.net ([217.227.153.3]:57245 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S279715AbRJ3BQz>;
	Mon, 29 Oct 2001 20:16:55 -0500
Date: Tue, 30 Oct 2001 02:17:40 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Cc: Marco Maisenhelder <hi41@iss.mach.uni-karlsruhe.de>, oesi@schmorp.de
Subject: 2.4.13-ac5 && vtun not working
Message-ID: <20011030021740.A8708@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marco Maisenhelder <hi41@iss.mach.uni-karlsruhe.de>, oesi
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux version 2.4.8-ac9 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading to linux-2.4.13-ac5, everything seems to work, except all
my vtun tunnels.

a _lot_ of searching revealed this code fragment:

        /*
         * Verify the string as this thing may have come from
         * the user.  There must be one "%d" and no other "%"
         * characters.
         */
        p = strchr(name, '%');
        if (!p || p[1] != 'd' || strchr(p+2, '%'))
                return -EINVAL;

Well, obviously my devicename _do_ come "from the user", as I really like
to name my tun devices (and everything else). The problem is that vtund
passes in "tun2" as devicename, which does not contain a "%d".

Maybe this piece of code is designed to fix security problems, but it
keeps vtund from working properly.

How about this change?

-        if (!p || p[1] != 'd' || strchr(p+2, '%'))
+        if (p && (p[1] != 'd' || strchr(p+2, '%')))


-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
