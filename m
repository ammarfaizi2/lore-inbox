Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131335AbRC0OgD>; Tue, 27 Mar 2001 09:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131336AbRC0Ofx>; Tue, 27 Mar 2001 09:35:53 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:267 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131335AbRC0Ofn>; Tue, 27 Mar 2001 09:35:43 -0500
Date: Tue, 27 Mar 2001 09:34:56 -0500
From: Chris Mason <mason@suse.com>
To: Christoph Lameter <christoph@lameter.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS phenomenon with 2.4.2 ac24/ac12
Message-ID: <206950000.985703696@tiny>
In-Reply-To: <Pine.LNX.4.21.0103261841240.31038-100000@home.lameter.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, March 26, 2001 06:57:37 PM -0800 Christoph Lameter
<christoph@lameter.com> wrote:

> On Mon, 26 Mar 2001, Chris Mason wrote:
>> On Monday, March 26, 2001 03:21:29 PM -0800 Christoph Lameter
>> > On Mon, 26 Mar 2001, Chris Mason wrote:
>> >> On Saturday, March 24, 2001 11:56:08 AM -0800 Christoph Lameter
>> >> <christoph@lameter.com> wrote:
>> >> > I got a directory /a/yy that I tried to erase with rm -rf /a/yy.
>> >> > 
>> >> > rm hangs...
>> >> > 
>> >> > ls gives the following output:
>> >> > 
>> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
>> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
>> >> > ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No
>> >> > such file or directory
>> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
>> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
>> >> > ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No
>> >> > such file or directory
>> >> > 
>> >> > 
> output of reiserfsck:
> 
> grow_id_map: objectid map expanded: used 1024, 1 blocks

These are harmless and should have been removed from fsck forever ago.

> bad_leaf: block 9454 has invalid item 4: 1928 5204 0x1 DIR, len 184,

This is probably the cause of the errors.  hopefully /a is inode number
1928 and /a/yy is inode number 5204 ( you can check with ls -i ).  Please
send me (privately) the output of debugreiserfs -b 9454, and we'll figure
out the best way to fix it.

> check_semantic_tree: hash mismatch detected (cache3A0F94EA0A00557.html)
> check_semantic_tree: name "cache3A0F94EA0A00557.html" in directory 1928
> 5204 points to nowhere check_semantic_tree: hash mismatch detected
> (cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb) check_semantic_tree:
> name "cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb" in directory
> 1928 5204 points to nowhere

And these are in the bad directory mentioned above.

-chris




