Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVILPjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVILPjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVILPjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:39:52 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:61157 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1750712AbVILPjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:39:51 -0400
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
Reply-To: bernd-schubert@gmx.de
To: netdev@oss.sgi.com
Subject: 2.613: network write socket problems
Date: Mon, 12 Sep 2005 17:39:45 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509121739.46172.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on last Friday  we switched on our server to 2.6.13 and today we are 
experiencing problems with our nfs clients.
In particular I'm talking about the unfs3 daemon, not the kernel nfs daemon. 
Both are running on the server but on different ports, of course.  Both are 
also serving to the same clients, but different directories.

Today it already several times happend that the unfs3 daemon stalled. Ethereal 
showed no network packages on the unfs3 daemon port during this time. 
A strace to the proc-id of the daemon clearly shows that *some* writes to some 
network sockets will take ages to finish

write(37, "\200\0\0x\203\326(\5\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 124) = 
124

This kind of writes can take between seconds and minutes, while it usually 
happens much faster than I can count. After the write() to the network 
socket, other operations happen rather fast, until the next write to a 
network socket. (I identified the troublesome filedescriptors by looking 
to /proc/procid/fd).
After restarting the unfs3 daemon everything goes smooth for some time 
(approximately 20min to 2h), until the next write to a filedescriptor stalls.

Any idea whats going on? Until today this never happend before, neither with 
2.6.x nor 2.4.x. As I wrote, on Friday we replaced 2.6.11.12 by 2.6.13, the 
configuration should be similar, only changes should be HZ set to 250 and 
additionally the skge driver. 
We already switched back from skge to sk98lin, but the problem seems to 
remain. 


Thanks,	
	Bernd



-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
