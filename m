Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTDKW12 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTDKW12 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:27:28 -0400
Received: from gate.in-addr.de ([212.8.193.158]:29136 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261851AbTDKW11 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:27:27 -0400
Date: Sat, 12 Apr 2003 00:38:56 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Steven Dake <sdake@mvista.com>, Greg KH <greg@kroah.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411223856.GI21726@marowsky-bree.de>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com> <3E9741FD.4080007@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E9741FD.4080007@mvista.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-04-11T15:30:21,
   Steven Dake <sdake@mvista.com> said:

> There is no "spec" that states this is a requirement, however, telecom 
> customers require the elapsed time from the time they request the disk 
> to be used, to the disk being usable by the operating system to be 20 msec.

Heh. Yes, I've read that spec, and some of it involves some good crack smoking
;-) The current Linux scheduler will make that rather hard for you, you'll
need hard realtime for such guarantees.

> Its even more helpful for their applications if the call that hotswap 
> inserts blocks until the device is actually ready to use and available 
> in the filesystem.  Another requirement of any system that attempts to 
> replace devfs would be this capability (vs constantly checking for the 
> device in the filesystem).

Uh. Can you please clarify?

You want open(/dev/not_there_yet) to block until /dev/not_there_yet is
inserted? But if it is not inserted, the device file does not exist yet, so
the open() will simply return a ENOENT.

The application (or a library, providing this capability you want) could
interact with the hotplug subsystem to be notified when this device is
inserted.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
