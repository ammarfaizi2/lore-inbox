Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130860AbRASHsF>; Fri, 19 Jan 2001 02:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131082AbRASHsA>; Fri, 19 Jan 2001 02:48:00 -0500
Received: from dwdmx2.dwd.de ([141.38.2.10]:62829 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S130860AbRASHrc>;
	Fri, 19 Jan 2001 02:47:32 -0500
Date: Fri, 19 Jan 2001 08:47:23 +0100 (CET)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: <linux-kernel@vger.kernel.org>
Subject: More filesystem corruption under 2.4.1-pre8 and SW Raid5
Message-Id: <Pine.LNX.4.30.0101190845280.28348-300000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="646811434-3072538-979890443=:28348"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--646811434-3072538-979890443=:28348
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello

Trying to find a quick way to reproduce the filesystem corruption
I reported earlier, I have written a short program that simply creates
a certain number of files in a given directory. Now if I start this
program 9 times each creating 50000 files (each 2048 Bytes) in 9
different directories and then delete these files again I always get
filesystem corruption.

I admit that creating 50000 files in one directory is not something
very common, but in my other test there are simply to many process
creating and deleting files and took too long to reproduce. My
assumption is that something goes wrong somewhere as soon as a
certain number files have been created.

The test where done on two different machines both SMP, SW Raid 5
and ext2 filesystem. Under 2.4.1-pre3 and pre8 I always get filesystem
corruption. This does NOT happen under 2.2.18.

I don't know if this is due to a problem in the Raid 5, ext2 filesystem
or in the kernel. Also, I do not currently have a system with 2.4.x
without raid5. For this reason I have attached two files (one C program
and a script) with the code that corrupts my filesystem. To run it you
need to issue the following commands:

    cc -o fsd fsd.c
    mkdir testdir
    cp fsd start_fsd testdir
    cd testdir
    chmod 755 start_fsd
    ./start_fsd

    now you need to wait 3 or 4 hours and you should see some
    ext2 errors in your syslog.

WARNING: This corrupts you filesystem really badly! Sometimes
         only the files in the testdir are effected. However, I
         had cases where other files where also effected. The
         system sometimes behaves very strangely after the test,
         programs that always have worked just crash. Reconstruction
         with fsck does not always work properly, sometimes there are
         very strange files scattered over the whole filesystem
         afterwards.  So be warned, do this on a test filesystem and boot
         the machine after the test!

Another thing I notice is that the responsiveness of the machine
decreases dramatically as the test progresses until it is nearly
useless. After the test is done everything is back to normal.
The same behavior was observed under 2.2.18.

Holger

--646811434-3072538-979890443=:28348
Content-Type: TEXT/plain; name="fsd.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0101190847230.28348@talentix.dwd.de>
Content-Description: 
Content-Disposition: attachment; filename="fsd.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+DQojaW5j
bHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQojaW5j
bHVkZSA8c3lzL3N0YXQuaD4NCiNpbmNsdWRlIDxmY250bC5oPg0KI2luY2x1
ZGUgPGRpcmVudC5oPg0KI2luY2x1ZGUgPGVycm5vLmg+DQoNCnN0YXRpYyB2
b2lkIGNyZWF0ZV9maWxlcyhpbnQsIGludCwgY2hhciAqKSwNCiAgICAgICAg
ICAgIGRlbGV0ZV9maWxlcyhjaGFyICopOw0KDQoNCi8qJCQkJCQkJCQkJCQk
JCQkJCQkJCQkJCQkJCQkJCQkJCQgZnNkICQkJCQkJCQkJCQkJCQkJCQkJCQk
JCQkJCQkJCQkJCQkJCQqLw0KaW50DQptYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pDQp7DQogICBpbnQgIG5vX29mX2ZpbGVzLA0KICAgICAgICBmaWxl
X3NpemU7DQogICBjaGFyIGRpcm5hbWVbMTAyNF07DQoNCiAgIGlmIChhcmdj
ID09IDQpDQogICB7DQogICAgICBub19vZl9maWxlcyA9IGF0b2koYXJndlsx
XSk7DQogICAgICBmaWxlX3NpemUgPSBhdG9pKGFyZ3ZbMl0pOw0KICAgICAg
KHZvaWQpc3RyY3B5KGRpcm5hbWUsIGFyZ3ZbM10pOw0KICAgfQ0KICAgZWxz
ZQ0KICAgew0KICAgICAgKHZvaWQpZnByaW50ZihzdGRlcnIsDQogICAgICAg
ICAgICAgICAgICAgICJVc2FnZTogJXMgPG51bWJlciBvZiBmaWxlcz4gPGZp
bGUgc2l6ZT4gPGRpcmVjdG9yeT5cbiIsDQogICAgICAgICAgICAgICAgICAg
IGFyZ3ZbMF0pOw0KICAgICAgZXhpdCgxKTsNCiAgIH0NCiAgIGNyZWF0ZV9m
aWxlcyhub19vZl9maWxlcywgZmlsZV9zaXplLCBkaXJuYW1lKTsNCiAgIGRl
bGV0ZV9maWxlcyhkaXJuYW1lKTsNCiAgIGV4aXQoMCk7DQp9DQoNCg0KLyor
KysrKysrKysrKysrKysrKysrKysrKysrKysgY3JlYXRlX2ZpbGVzKCkgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKyovDQpzdGF0aWMgdm9pZA0KY3Jl
YXRlX2ZpbGVzKGludCBub19vZl9maWxlcywgaW50IGZpbGVfc2l6ZSwgY2hh
ciAqZGlybmFtZSkNCnsNCiAgIGludCAgaSwgZmQ7DQogICBjaGFyICpwdHI7
DQoNCiAgIHB0ciA9IGRpcm5hbWUgKyBzdHJsZW4oZGlybmFtZSk7DQogICAq
cHRyKysgPSAnLyc7DQogICBmb3IgKGkgPSAwOyBpIDwgbm9fb2ZfZmlsZXM7
IGkrKykNCiAgIHsNCiAgICAgICh2b2lkKXNwcmludGYocHRyLCAidGhpc19p
c19kdW1teV9maWxlXyVkIiwgaSk7DQogICAgICBpZiAoKGZkID0gb3Blbihk
aXJuYW1lLCBPX0NSRUFUfE9fUkRXUiwgU19JUlVTUnxTX0lXVVNSKSkgPT0g
LTEpDQogICAgICB7DQogICAgICAgICAodm9pZClmcHJpbnRmKHN0ZGVyciwg
IkZhaWxlZCB0byBvcGVuKCkgJXMgOiAlc1xuIiwNCiAgICAgICAgICAgICAg
ICAgICAgICAgZGlybmFtZSwgc3RyZXJyb3IoZXJybm8pKTsNCiAgICAgICAg
IGV4aXQoMSk7DQogICAgICB9DQogICAgICBpZiAobHNlZWsoZmQsIGZpbGVf
c2l6ZSAtIDEsIFNFRUtfU0VUKSA9PSAtMSkNCiAgICAgIHsNCiAgICAgICAg
ICh2b2lkKWZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIGxzZWVrKCkgJXMg
OiAlc1xuIiwNCiAgICAgICAgICAgICAgICAgICAgICAgZGlybmFtZSwgc3Ry
ZXJyb3IoZXJybm8pKTsNCiAgICAgICAgIGV4aXQoMSk7DQogICAgICB9DQog
ICAgICBpZiAod3JpdGUoZmQsICIiLCAxKSAhPSAxKQ0KICAgICAgew0KICAg
ICAgICAgKHZvaWQpZnByaW50ZihzdGRlcnIsICJGYWlsZWQgdG8gd3JpdGUo
KSB0byAlcyA6ICVzXG4iLA0KICAgICAgICAgICAgICAgICAgICAgICBkaXJu
YW1lLCBzdHJlcnJvcihlcnJubykpOw0KICAgICAgICAgZXhpdCgxKTsNCiAg
ICAgIH0NCiAgICAgIGlmIChjbG9zZShmZCkgPT0gLTEpDQogICAgICB7DQog
ICAgICAgICAodm9pZClmcHJpbnRmKHN0ZGVyciwgIkZhaWxlZCB0byBjbG9z
ZSgpICVzIDogJXNcbiIsDQogICAgICAgICAgICAgICAgICAgICAgIGRpcm5h
bWUsIHN0cmVycm9yKGVycm5vKSk7DQogICAgICB9DQogICB9DQogICBwdHJb
LTFdID0gMDsNCiAgIHJldHVybjsNCn0NCg0KDQovKisrKysrKysrKysrKysr
KysrKysrKysrKysrKysgZGVsZXRlX2ZpbGVzICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKi8NCnN0YXRpYyB2b2lkDQpkZWxldGVfZmlsZXMoY2hh
ciAqZGlybmFtZSkNCnsNCiAgIGNoYXIgICAgICAgICAgKnB0cjsNCiAgIHN0
cnVjdCBkaXJlbnQgKmRpcnA7DQogICBESVIgICAgICAgICAgICpkcDsNCg0K
ICAgcHRyID0gZGlybmFtZSArIHN0cmxlbihkaXJuYW1lKTsNCiAgIGlmICgo
ZHAgPSBvcGVuZGlyKGRpcm5hbWUpKSA9PSBOVUxMKQ0KICAgew0KICAgICAg
KHZvaWQpZnByaW50ZihzdGRlcnIsICJGYWlsZWQgdG8gb3BlbmRpcigpICVz
IDogJXNcbiIsDQogICAgICAgICAgICAgICAgICAgIGRpcm5hbWUsIHN0cmVy
cm9yKGVycm5vKSk7DQogICAgICBleGl0KDEpOw0KICAgfQ0KICAgKnB0cisr
ID0gJy8nOw0KICAgd2hpbGUgKChkaXJwID0gcmVhZGRpcihkcCkpICE9IE5V
TEwpDQogICB7DQogICAgICBpZiAoZGlycC0+ZF9uYW1lWzBdICE9ICcuJykN
CiAgICAgIHsNCiAgICAgICAgICh2b2lkKXN0cmNweShwdHIsIGRpcnAtPmRf
bmFtZSk7DQogICAgICAgICBpZiAodW5saW5rKGRpcm5hbWUpID09IC0xKQ0K
ICAgICAgICAgew0KICAgICAgICAgICAgKHZvaWQpZnByaW50ZihzdGRlcnIs
ICJGYWlsZWQgdG8gb3BlbigpICVzIDogJXNcbiIsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgIGRpcm5hbWUsIHN0cmVycm9yKGVycm5vKSk7DQogICAg
ICAgICAgICBleGl0KDEpOw0KICAgICAgICAgfQ0KICAgICAgfQ0KICAgfQ0K
ICAgcHRyWy0xXSA9IDA7DQogICBpZiAoY2xvc2VkaXIoZHApID09IC0xKQ0K
ICAgew0KICAgICAgKHZvaWQpZnByaW50ZihzdGRlcnIsICJGYWlsZWQgdG8g
Y2xvc2VkaXIoKSAlcyA6ICVzXG4iLA0KICAgICAgICAgICAgICAgICAgICBk
aXJuYW1lLCBzdHJlcnJvcihlcnJubykpOw0KICAgfQ0KICAgcmV0dXJuOw0K
fQ0K
--646811434-3072538-979890443=:28348
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=start_fsd
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0101190847231.28348@talentix.dwd.de>
Content-Description: 
Content-Disposition: attachment; filename=start_fsd

IyEvYmluL3NoDQoNCk5PX09GX1BST0NFU1M9OQ0KTlVNQkVSX09GX0ZJTEVT
PTUwMDAwDQpGSUxFX1NJWkU9MjA0OA0KDQpjb3VudGVyPTANCndoaWxlIFsg
JGNvdW50ZXIgLWx0ICROT19PRl9QUk9DRVNTIF0NCmRvDQogICBpZiBbICEg
LWQgJGNvdW50ZXIgXQ0KICAgdGhlbg0KICAgICAgbWtkaXIgJGNvdW50ZXIN
CiAgIGZpDQogICAuL2ZzZCAkTlVNQkVSX09GX0ZJTEVTICRGSUxFX1NJWkUg
JGNvdW50ZXIgJg0KICAgY291bnRlcj1gZXhwciAiJGNvdW50ZXIiICsgMWAN
CmRvbmUNCg==
--646811434-3072538-979890443=:28348--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
