Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbTDGWxt (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbTDGWwB (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:52:01 -0400
Received: from siaag1ac.compuserve.com ([149.174.40.5]:42172 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S263761AbTDGWvb (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:51:31 -0400
Date: Mon, 7 Apr 2003 19:00:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: subobj-rmap
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Rik van Riel <riel@surriel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304071902_MC3-1-3368-B950@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

1) |----------------------|
2)     |-----------|
3) |--------------------------|
4)         |-----------|

R) |---|---|-------|---|--|---|

    1   1   1       1   1  3
    3   2   2       3   3
        3   3       4
            4


 How's this for an alogorithm for finding which
chunk of 'R' you have hit with a given memory reference:

 o  Use a bitmap to represent the whole address range.
 o  Set the bits that correspond the the first page
    of each subregion.

 To search:

 o  Look up the bit for the page you are interested in.
 o  Scan backwards for a 1.
 o  Convert bit position to address, this is the
    base of the subregion.

 Since this is i386-only you can play neat assembler
tricks with this code to make it fast.

 (OS/2 did/does it that way.)

--
 Chuck
 I am not a number!
