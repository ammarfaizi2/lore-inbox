Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWF0SkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWF0SkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWF0SkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:40:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:53081 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030256AbWF0SkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:40:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K01MXIxyh5kLV/JPon6BYAOywkCd5rg/sGteQ5EHqWb1Aj+g87XGNfArL/uSDSDgHc1RWwKpc1ZV1p/vrBOiQyfTmuUUxoDI/RpU0aEceOqVEHbQB0ZVdAfCazWBLDP73N3Y2zxqXxejt8FVKOrBuaqN5bH+G9p6M6FA/qAd9ws=
Message-ID: <dba10b900606271140o64b60c97kecb8177f801ff9f4@mail.gmail.com>
Date: Tue, 27 Jun 2006 13:40:06 -0500
From: "Greg Bledsoe" <greg.bledsoe@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: pmap, smap, process memory utilization
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings

Our shop runs IBM ldap servers which use a DB2 backend for the data
store.  I and a coworker have been charged with figuring out how much
memory ldap and DB2 are using.  I became nervous, having been down the
"can I get granular memory information" path before.  We came back the
results of watch "free -m" in various scenarios and with the RSS for
the two processes and were asked a lot of questions about the output
of ps and top and what does VSS mean and etc.  I answered with lots of
tedious information on why these tools don't provide an accurate
picture of actual memory utilization due to shared objects, IPC shared
memory, copy on write after forks, and a lot of other factors.  I
responded to short questions with long answers and got frowns in
response.  Capacity planning wants to forecast with more precision
than I can currently offer data for.

To turn those frowns upside down (and satisfy our own curiosity) our idea is to:

Get the map (cat /proc/$PID/maps) with start-stop address ranges for
what that proccess has mapped.

Enumerate the list of all addresses, ie - this process has addresses
1-5 and 9-11; or 1,2,3,4,5,9,10,11 - this process has 1-3 and 12-14,
or 1,2,3,12,13,14

Compare the lists and count each page only once.  So in the above
example only count 1,2,3,4,5,9,10,11,12,13,14 for a total of 11
addresses in use.

This should give a count of each unique memory address, and will avoid
double counting IPC shared memory.  It should be possible to either
include or exclude shared libraries, as desired, and if run
collectively on all processes, should give a total count equal to what
is reported by the "free" command.

I fully expect that there is either something here I don't understand
that prevents this from giving an accurate count, or that I am
duplicating the work someone else has done.

In any case I apologize for the bother and thank you for your time.


-- 
   Greg Bledsoe

    ----------
    I owe my success to having listened respectfully to the very best
advice, and going and doing the exact opposite.
    G.K. Chesterton
