Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTAJNA0>; Fri, 10 Jan 2003 08:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbTAJNA0>; Fri, 10 Jan 2003 08:00:26 -0500
Received: from hera.cwi.nl ([192.16.191.8]:58547 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264886AbTAJNAY>;
	Fri, 10 Jan 2003 08:00:24 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 10 Jan 2003 14:08:53 +0100 (MET)
Message-Id: <UTC200301101308.h0AD8r021919.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: sd_read_cache_type
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last year I wrote half a dozen drivers for various USB card readers.
Some don't work anymore with 2.5.recent.
I just investigated one. The reason it stopped working is the
  sd_read_cache_type()
call added in 2.5.41. (With that call removed it works again.)

Will look a bit more at the details later.
For now a question: this call does a MODE_SENSE with the DBD
(disable block descriptors) bit set. Is there a reason for that?
Wouldn't the same code work in the same way without that bit?

And the reason I ask is that we already have sd_do_mode_sense6(),
so part of sd_read_cache_type() can be simply replaced by a call
of sd_do_mode_sense6(), but the latter needs an extra parameter
if DBD is really needed.

And a second question: sd_read_cache_type() is called also
when no medium is present. Objections against only calling
when media are present?

Andries
