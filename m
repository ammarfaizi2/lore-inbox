Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbSL2PQd>; Sun, 29 Dec 2002 10:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbSL2PQd>; Sun, 29 Dec 2002 10:16:33 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:50700 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S266367AbSL2PQc>; Sun, 29 Dec 2002 10:16:32 -0500
Message-ID: <20021229162452.A3412@it.et.tudelft.nl>
Date: Sun, 29 Dec 2002 16:24:52 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: David Anderson <david-ander2023@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: Reading a file in the driver
References: <20021227151332.26696.qmail@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20021227151332.26696.qmail@mail.com>; from David Anderson on Fri, Dec 27, 2002 at 10:13:32AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 10:13:32AM -0500, David Anderson wrote:
> I am reading some data from a file byte by byte in my driver. Although it's not a good thing to read a file in the driver I have to do it. My file is quite big can contain about 1000 lines each line containing anywhere from 0 to 500 characters. I believe carry out 500000 reads is not a good thing. 
> 
> Any suggestions on how I can improve ??

Sure, do it from userland. Make a device node to which userland can write
the file you want. This nicely removes the policy problem of *which* file
to read from *what* location and puts it were it belongs: userland. With
this setup you can even read files from such exotic locations like other
servers or SQL databases.

If the driver needs to initiate the file reading, just startup a userland
helper that does the reads for you. See for example how the hotplug
subsystem calls /sbin/hotplug.


Erik

-- 
J.A.K. (Erik) Mouw
J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org
http://www-ict.its.tudelft.nl/~erik/
