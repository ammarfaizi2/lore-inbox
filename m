Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbUKRPox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUKRPox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUKRPnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:43:08 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:23702 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262488AbUKRPlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:41:42 -0500
Date: Thu, 18 Nov 2004 16:40:52 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       r6144 <rainy6144@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       phillips@istop.com, Alex Tomas <alex@clusterfs.com>,
       Christopher Li <chrisl@vmware.com>,
       Christopher Li <ext2-devel@chrisli.org>
Subject: Re: Fw: [POSSIBLE-BUG] telldir() broken on ext3 dir_index'd directories
 just after the first entry.
In-Reply-To: <20041118140645.GA5306@thunk.org>
Message-ID: <Pine.LNX.4.53.0411181638000.24023@yvahk01.tjqt.qr>
References: <20041116183813.11cbf280.akpm@osdl.org> <20041117223436.GB5334@thunk.org>
 <1100736003.11047.14.camel@sisko.sctweedie.blueyonder.co.uk>
 <20041118045336.GA5236@thunk.org> <Pine.LNX.4.53.0411181221360.12219@yvahk01.tjqt.qr>
 <20041118140645.GA5306@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >So instead what we need to do is wire '.' and '..' to have hash values
>> >of (0,0) and (2,0), respectively, without ignoring other existing
>> >dirents with colliding hashes.  (In those cases the programs will
>> >break, but they are statistically rare, and there's not much we can do
>> >in those cases anyway.)
>>
>> IMO it's better to fix the mess all at once to have it weeded out for some
>> months.
>
>Programs that assume that '.' and '..' are the first and second [...]
>But there's really not much we can do.
>
>Before, we hard-wired '.' and '..' to always be first [...]
>We don't really have a choice here.
>
>(Actually, I guess we could define a new hash function [...]
>So again, making a best effort, but breaking programs
>that are fundamentally broken is the best we can do.)

Looks like there's only way -- or: two ways and one choice:

- Either leave it all as it is ATM (kind of unsatisfying) or

- (unintentionally) break all apps now, or announce that they could brake if they
relied on special features (as outlined above), and at the same time implement
proper directory traversal.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
