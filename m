Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbUKXPxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbUKXPxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUKXPv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:51:58 -0500
Received: from zeus.kernel.org ([204.152.189.113]:58530 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262759AbUKXPuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:50:39 -0500
Date: Wed, 24 Nov 2004 15:26:33 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: *** Announcement: dmraid 1.0.0-rc5f ***
Message-ID: <20041124142633.GA16708@redhat.com>
Reply-To: mauelshagen@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


               *** Announcement: dmraid 1.0.0-rc5f ***

dmraid 1.0.0-rc5f is available at
http://people.redhat.com:/heinzm/sw/dmraid/ in source, source rpm and i386 rpm.

dmraid (Device-Mapper Raid tool) discovers, [de]activates and displays
properties of software RAID sets (i.e. ATARAID) and contained DOS
partitions using the device-mapper runtime of the 2.6 kernel.

The following ATARAID types are supported on Linux 2.6:

Highpoint HPT37X
Highpoint HPT45X
Intel Software RAID
NVidia NForce		*** NEW ***
Promise FastTrack
Silicon Image Medley

This ATARAID type is only basically supported in this version (I need
better metadata format specs; please help):

LSI Logic MegaRAID

Please provide insight to support those metadata formats completely.

Thanks.


See files README and CHANGELOG, which come with the source tarball for
prerequisites to run this software, further instructions on installing
and using dmraid!

CHANGELOG is contained below for your convenience as well.


Call for testers:
-----------------

I need testers with the above ATARAID types, to check that the mapping
created by this tool is correct (see options "-t -ay") and access to the
ATARAID data is proper.

In case you have a different ATARAID solution from those listed above,
please feel free to contact me about supporting it in dmraid.

You can activate your ATARAID sets without danger of overwriting
your metadata, because dmraid accesses it read-only unless you use
option -E together with -r in order to erase ATARAID metadata
(see 'man dmraid')!

This is a release candidate version so you want to have backups of your valuable
data *and* you want to test accessing your data read-only first in order to
make sure that the mapping is correct before you go for read-write access.


Contacts:
---------

The author is reachable at <Mauelshagen@RedHat.com>.

For test results, mapping information, discussions, questions, patches,
enhancement requests and the like, please subscribe and mail to
<ataraid-list@redhat.com>.

--

Regards,
Heinz    -- The LVM Guy --


CHANGELOG:
---------

FIXES:
------
o make suffix in hpt45x set names numeric
o HPT37x metadata format handler RAID10 grouping logic
o HPT37x/HPT45x avoid devision by zero bug
  in case ->raid_disks is zero for spares
o avoid devision by zero bug in case of stride = 0
o SIL device names / checksums
o calc_total_sectors() on unsymmetric mirrors
o Partition name suffix to make GRUB happy
o perform() could return an error without releasing a lock


FEATURES:
---------
o added NVidia metadata format handler
o quorate SIL metadata copies
o sorting order of stacked subset enhanced
  (RAID10; hpt37x, hpt45x, lsi, nvidia and sil)
o started event methods implementation in metadata format handlers
o output linefeed to .offset files for better readability (-r -D)
o use /sys/block/*/removable to avoid acessing removable devices
o display of spare devices with -r -c{0,2}
o enhanced spare device handling
o '-h' option doesn't need to stand alone any more
o -s displays top level sets only. "-s -s" shows subsets as well.
o -f allows partial qualification of format names now
  (eg, "dmraid -f hpt -r" will search for hpt37x and hpt45x formats)


MISCELANIOUS:
------------
o HPT37X shows subset name suffixes with -r
o streamlined display.c
o added lib_context* argument to alloc_disk_info() in order
  to be able to display an error message on failure
o factored basic RAID set allocation code out of
  all metadata format handler into find_or_alloc_set()
o factored RAID superset allocation code out of metadata format
  handlers into join_superset()
o streamlined endianess code using CVT* macros
o streamlined free_set() code
o check option enum valid
o introduced various metadata extraction macros to streamline
  related code (eg, RD(), RS())
o optimized format handler pre-registration checks
o avoid format handler type() method altogether by introducing
  a RAID device type member
o generalized list_add_sorted() which can be used to sort any
  "struct list_head*" which voided list_add_dev_sorted()
o find_set() modified to avoid global searches for stacked sets
o converted get_scsi_serial to fallback using SG_IO,
  SCSI_IOCTL_SEND_COMMAND and ATA identify
o introduced p_fmt() for formated string pushs in order to
  streamline activate.c; value return code of p_fmt()
o moved some paths + filenames to lib_context
o introduced RAID set flag for metadata format handlers 
  which decide to maximize capacity in unsymetric RAID0 sets
o factored out device information allocation of scan.c into metadata.c
o introduced RAID device list to library context in order to remove
  pointer from device info and be able to handle remaining RAID device
  structures better on library cleanup
o streamlined commands.c
o changed column output delimiter to ':'
o introduced various enums replacing integers


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
