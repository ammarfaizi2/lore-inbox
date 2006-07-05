Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWGESZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWGESZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWGESZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:25:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:19046 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964969AbWGESZL convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:25:11 -0400
X-IronPort-AV: i="4.06,210,1149490800"; 
   d="scan'208"; a="60891134:sNHT53430540975"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Date: Wed, 5 Jul 2006 22:10:33 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06CF96@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcagWJqGedXWZ0XkRD6t+UuyoJQXhwAAbJ3A
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Bret Towe" <magnade@gmail.com>, "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jul 2006 18:10:48.0845 (UTC) FILETIME=[57E233D0:01C6A05E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bret Towe writes:
> if say some gtk app wants to write to disk it will freeze
> until the usb hd is completely done

The proposed patch fixes one real cause of long latency: if a user
thread writes 1 byte only to disk it could happen that one has to write
all pages dirtied by all threads in the system and wait for it. The
patch is tested and gets real benefit on real systems. A common system
work is performed in common system thread but not in casual user thread.

The patch does not fix other (bazillion - 1) fictitious freezing causes
for imaginary configurations.

Leonid
-----Original Message-----
From: Bret Towe [mailto:magnade@gmail.com] 
Sent: Wednesday, July 05, 2006 9:19 PM
To: Nikita Danilov
Cc: Ananiev, Leonid I; Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

On 7/5/06, Nikita Danilov <nikita@clusterfs.com> wrote:
> Bret Towe writes:
>
> [...]
>
>  >
>  > are you sure about that? cause that sounded alot like an issue
>  > i saw with slow usb devices (mainly a usb hd on a usb 1.1
connection)
>  > the usb device would fill up with write queue and local io to say
/dev/hda
>  > would basicly stop and the system would be rather useless till the
usb
>  > hd would finish writing out what it was doing
>  > usally would take several hundred megs of data to get it to do it
>
> There may be bazillion other reasons for slow device making system
> unresponsive in various ways. More details are needed (possibly in
> separate thread).

well at this time all i know is one will be writing to the usb hd its
queue
will fill up and if say some gtk app wants to write to disk it will
freeze
until the usb hd is completely done
i will look into it at some point when i have time and get more info on
it and post a proper report on the issue unless its already been fixed

>  >
>  > ive not tried it in ages so maybe its been fixed since ive last
tried it
>  > dont recall the kernel version at the time but it wasnt more than a
>  > year ago
>  >
>
> Nikita.
>
