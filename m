Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUHCIJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUHCIJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 04:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUHCIJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 04:09:13 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:62925
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S265139AbUHCIJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 04:09:02 -0400
Message-ID: <410F481C.9090408@bio.ifi.lmu.de>
Date: Tue, 03 Aug 2004 10:09:00 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS-mounted, read-only /dev unusable in 2.6 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we boot diskless clients using nfsroot. The server exports
its own / with "ro,no_root_squash" and the clients mount it via
the nfsroot parameter. Then I run my own init script to mount
client specific /dev, /var, /etc all rw.

In this scenario, the 2.6.7 kernel fails to open an initial
console, since /dev is ro.

The 2.4 kernel was able to open an initial console, and
I could also echo sth. explicitely to /dev/console, even
when it was still the ro-mounted fs from the server.

With the 2.6.7 kernel, this will fail with "permission denied",
and that's why the kernel cannot open an initial console.
It will go on silently until I mount the client-specific
/dev in my init script and redirect all output.

Similar, using /dev/ram0 for creating an initial ramdisk
will fail when / is mounted ro from the server, and server
and client use both kernel 2.6.7. If the client runs
2.4, it is possible...

Is that change between 2.4 and 2.6 desired or a bug? It sounds
correct that one cannot use a node "/dev/console" for writing
if it is mounted read-only from a NFS server, but it was very
useful in 2.4.

Or is there any other way to get an initial console or
output any messages from an init script if one boots via nfsroot
and  / (and thus, /dev) is only exported read-only from the
server?

I need that to get possible error messages from my own init
script to see what fails before I mount the client /dev.

cu,
Frank
-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

