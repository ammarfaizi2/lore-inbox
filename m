Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVEOTeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVEOTeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 15:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEOTeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 15:34:50 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:50636 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261215AbVEOTa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 15:30:27 -0400
Message-ID: <4287A323.6010209@cs.wisc.edu>
Date: Sun, 15 May 2005 12:29:39 -0700
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: open-iscsi@googlegroups.com, netdev <netdev@oss.sgi.com>,
       linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org,
       linux-iscsi-devel <linux-iscsi-devel@lists.sourceforge.net>
Subject: [PATCH 0/3] add open iscsi netlink interface to iscsi transport class
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add the linux-iscsi-5.X/open-iscsi project's
netlink interface to the iscsi transport class.

Last time I messed up and did not inline the patches so the reason for
the allignment in some structures was not clear. There was also a bug in
that unsigned long was being used instead of u64/unit64_t so that
complicated matters. We have been discussing this internally but I am
not sure I know the best route - I had hoped to just be able to remove
them all like was suggested, so I am reposting the patches inlined with
hopefully at least Chris Wright and almost all of Christoph Hellwig's
comments addressed.

The one suggestion we were not able to complete was the one to move the
scsi_remove_host and scsi_host_add calls. It is trivial to do, but
seemed odd since every iscsi_transport would need to add these calls. I
can understand in the future when HW iSCSI is supported all our
scsi_host lifetime code will need to be reworked because they allocate a
host per pci device and we allocate a host per session (maybe a common
place to meet would be a host per initiator port), but with only
software iSCSI supported today maybe a little more info is needed. Is
the suggestion to move the add/remove host calls to the iscsi_transport
to allow the transport to control when they want to begin queueing comamnds?

Maybe the removal of ISCSI_TRANSPORT_MAX is also not completely met too.
I am hoping to finish fixing that by exposing the same information
through sysfs, but I am still trying to figure out how the layout should
be implmented using the driver model transport classes and struct
devices or kobjects or whatever makes people happy. We could simply do 
this using driver model transport classes by just adding a 
iscsi_transport class that represents the iSCSI transport like 
iscsi_tcp, iscsi_iser and making that the parent of the session, but 
maybe that is better done in a seperate patch so we can discuss the 
abstraction for the parent of the session seperately.

More info about the open-iscsi/linux-iscsi-5 project can found here
http://open-iscsi.org/.

Patches

1. add-iscsi-netlink-def.patch - include/linux/netlink.h changes (added
new protocol NETLINK_ISCSI)

2.  common-iscsi-headers.patch - Common header files:
  - iscsi_if.h (user/kernel #defines);
  - iscsi_proto.h (RFC3720 #defines and types);
  - iscsi_ifev.h (user/kernel events).

3. integrate-iscsi-netlink.patch - incorporate the
open-iscsi/linux-iscsi netlink interface into the iscsi transport class.


Thanks,

Linux-iscsi Team


