Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTE2UaC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTE2UaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:30:02 -0400
Received: from cs.rice.edu ([128.42.1.30]:10132 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id S262645AbTE2UaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:30:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: Scott A Crosby <scrosby@cs.rice.edu>
Organization: Rice University
Date: 29 May 2003 15:42:39 -0500
Message-ID: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. We have analyzed this software to determine its vulnerability
to a new class of DoS attacks that related to a recent paper. ''Denial
of Service via Algorithmic Complexity Attacks.''

This paper discusses a new class of denial of service attacks that
work by exploiting the difference between average case performance and
worst-case performance. In an adversarial environment, the data
structures used by an application may be forced to experience their
worst case performance. For instance, hash tables are usually thought
of as being constant time operations, but with large numbers of
collisions will degrade to a linked list and may lead to a 100-10,000
times performance degradation. Because of the widespread use of hash
tables, the potential for attack is extremely widespread. Fortunately,
in many cases, other limits on the system limit the impact of these
attacks.

To be attackable, an application must have a deterministic or
predictable hash function and accept untrusted input. In general, for
the attack to be signifigant, the applications must be willing and
able to accept hundreds to tens of thousands of 'attack
inputs'. Because of that requirement, it is difficult to judge the
impact of these attack without knowing the source code extremely well,
and knowing all ways in which a program is used.

As part of this project, one of the applications examined was the
linux kernel 2.4.20, both the networking stack (subject of another
email) and in this email, the dcache.

I have confirmed via an actual attack that it is possible to force the
dcache to experience a 200x performance degradation if the attacker
can control filenames. On a P4-1.8ghz, the time to list a directory of
10,000 files is 18 seconds instead of .1 seconds.


The solution for these attacks on hash tables is to make the hash
function unpredictable via a technique known as universal
hashing. Universal hashing is a keyed hash function where, based on
the key, one of a large set hash functions is chosen. When
benchmarking, we observe that for short or medium length inputs, it is
comparable in performance to simple predictable hash functions such as
the ones in Python or Perl. Our paper has graphs and charts of our
benchmarked performance.

I highly advise using a universal hashing library, either our own or
someone elses. As is historically seen, it is very easy to make silly
mistakes when attempting to implement your own 'secure' algorithm.

The abstract, paper, and a library implementing universal hashing is
available at   http://www.cs.rice.edu/~scrosby/hash/.

Scott
