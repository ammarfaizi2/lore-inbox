Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbSJ0KPF>; Sun, 27 Oct 2002 05:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbSJ0KPF>; Sun, 27 Oct 2002 05:15:05 -0500
Received: from camus.xss.co.at ([194.152.162.19]:28686 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S262344AbSJ0KPE>;
	Sun, 27 Oct 2002 05:15:04 -0500
Message-ID: <3DBBBE1B.5050809@xss.co.at>
Date: Sun, 27 Oct 2002 11:21:15 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: rootfs exposure in /proc/mounts
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <3DBAE931.7000409@domdv.de> <3DBAEC79.5050605@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
[...]
> 
> Bug 1 - don't softlink directly to /proc/mounts :)  embedded guys 
> typically do this, and you see why it bites you in the ass :)
> 

Jeff, this remembers me on some discussion on LKML we had almost 
exactly 2 years ago (look for the thread starting with Message-ID 
Pine.LNX.4.02.10010251043060.5657-100000@rimbaud.xss.co.at)

Do you remember?

My opinion on this issue is still the same:

- Not only "embedded guys" symlink /etc/mtab to /proc/mounts!
   We do this for years now on our diskless workstations, because
   here our root-fs (and therefore /etc) is mounted readonly and
   so there is no way to update a _regular_ "/etc/mtab" file on
   a running system.

- /etc should contain only static configuration information.
   The table of mounted filesystems is not this kind of data.
   It's state information and should live somewhere else.

- the table of mounted filesystems is information which
   the kernel must have, anyway. Why maintain a separate
   file in userspace?

Comments?

- Andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71

